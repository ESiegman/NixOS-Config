# hosts/desktop/hardware.nix
{ inputs, pkgs, ... }: {
  swapDevices = [{
    device = "/swapfile";
    size = 32 * 1024;
  }];

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
        theme = inputs.nixos-grub-theme.packages.${pkgs.system}.hyperfluent;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules =
      [ "amdgpu" "xhci_pci" "ehci_pci" "nvme" "ahci" "sd_mod" "usb_storage" ];
    kernelModules = [ "amdgpu" "usbmtc" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "usbcore.quirks=0x00000000" "rootdelay=5" ];
  };

  environment.systemPackages = with pkgs; [ vulkan-tools networkmanagerapplet ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "radeonsi";
  };

  systemd.services.systemd-modules-load.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libvdpau-va-gl
        vaapiVdpau
        rocmPackages.clr
        rocmPackages.clr.icd
        rocmPackages.rocm-smi
        vulkan-loader
        vulkan-validation-layers
      ];
    };
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
      powerOnBoot = true;
      settings.General.Experimental = true;
    };
  };

  services = { blueman.enable = true; };

  security = {
    pam.services.hyprlock = { };
    polkit.enable = true;
    rtkit.enable = true;
    sudo.extraRules = [{
      users = [ "eren" ];
      commands = [{
        command = "/usr/bin/sed";
        options = [ "NOPASSWD" ];
      }];
    }];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "America/New_York";
  };
  i18n.defaultLocale = "en_US.UTF-8";
}

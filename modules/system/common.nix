# modules/system/common.nix
{ pkgs, ... }: {
  services = {
    udev = {
      enable = true;
      extraRules = ''
        # Arduino Nano ESP32
        SUBSYSTEM=="usb", ATTR{idVendor}=="2341", ATTR{idProduct}=="0070", MODE="0666", GROUP="dialout"
        SUBSYSTEM=="usb", ATTR{idVendor}=="2341", ATTR{idProduct}=="0071", MODE="0666", GROUP="dialout"
      '';
    };
    dbus.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    playerctld.enable = true;
    blueman.enable = true;
    printing.enable = true;
    fwupd.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = [ pkgs.sddm-astronaut ];
      theme = "sddm-astronaut-theme";
    };
  };

  swapDevices = [{
    device = "/swapfile";
    size = 32 * 1024;
  }];

  systemd.services.systemd-modules-load.enable = true;
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libvdpau-va-gl
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

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}


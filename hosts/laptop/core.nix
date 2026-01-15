# hosts/laptop/core.nix
{ pkgs, ... }:
let wallpaper = ../../modules/assets/images/wallpaper-laptop.jpg;
in {
  stylix.image = wallpaper;

  services = {
    xserver = { enable = true; };
    desktopManager.plasma6.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = false;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    thermald.enable = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      kitty = super.symlinkJoin {
        name = "kitty";
        paths = [ super.kitty ];
        buildInputs = [ super.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/kitty \
            --set __NV_PRIME_RENDER_OFFLOAD 1 \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia \
            --set VK_ICD_FILENAMES /run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json \
            --set KITI_ENABLE_WAYLAND 1
        '';
      };
    })
  ];

  systemd.user.services.libinput-gestures = {
    description = "Libinput Gestures";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
  };

  programs.light.enable = true;

  environment.systemPackages = with pkgs; [ acpi brightnessctl powertop ];
}

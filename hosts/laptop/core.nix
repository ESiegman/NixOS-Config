# hosts/laptop/core.nix
{ pkgs, ... }:
let wallpaper = ../../modules/assets/images/wallpaper-laptop.jpg;
in {
  nixpkgs.overlays = [
    (self: super: {
      kitty = pkgs.writeShellScriptBin "kitty" ''
        #!/bin/sh
        if [ -f "/run/current-system/sw/bin/nvidia-offload" ]; then
          exec /run/current-system/sw/bin/nvidia-offload ${super.kitty}/bin/kitty "$@"
        else
          exec ${super.kitty}/bin/kitty "$@"
        fi
      '';
    })
  ];

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

  systemd.user.services.libinput-gestures = {
    description = "Libinput Gestures";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
  };

  programs.light.enable = true;

  environment.systemPackages = with pkgs; [ acpi brightnessctl powertop ];
}

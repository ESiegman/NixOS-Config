# hosts/laptop/core.nix
{ pkgs, ... }:
let wallpaper = ../../modules/assets/images/wallpaper-laptop.png;
in {
  stylix.image = wallpaper;

  service = {
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.cinnamon.enable = true;
    };
    libinput.enable = true;
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

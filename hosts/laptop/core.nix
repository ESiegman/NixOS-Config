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

  home-manager.users.eren = {
    programs.kitty.package = pkgs.symlinkJoin {
      name = "kitty-wrapped-nvidia";
      paths = [ pkgs.kitty ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/kitty \
          --run "export __NV_PRIME_RENDER_OFFLOAD=1" \
          --run "export __GLX_VENDOR_LIBRARY_NAME=nvidia" \
          --run "export VK_ICD_FILENAMES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json"
      '';
    };
  };

  systemd.user.services.libinput-gestures = {
    description = "Libinput Gestures";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
  };

  programs.light.enable = true;

  environment.systemPackages = with pkgs; [ acpi brightnessctl powertop ];
}

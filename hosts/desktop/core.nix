# hosts/desktop/core.nix
{ lib, pkgs, ... }:
let wallpaper = ../../modules/assets/images/wallpaper-desktop.png;
in {
  stylix.image = wallpaper;

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  services = {
    xserver.videoDrivers = [ "amdgpu" ];
    openssh = {
      enable = true;
      # settings.PasswordAuthentication = false;
      # settings.KbdInteractiveAuthentication = false;
    };
    tumbler.enable = true;
  };
  blueman.enable = true;
  programs = {
    hyprland.enable = true;
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = { common = { default = [ "hyprland" ]; }; };
    #   mimeApps.defaultApplications = {
    #     "text/plain" = "nvim.desktop";
    #     "application/pdf" = "zathura.desktop";
    #     "image/*" = "gThumb.desktop";
    #     "video/*" = "mpv.desktop";
    #     "audio/*" = "mpv.desktop";
    #   };
  };
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "0";
      VIRTUAL_ENV_DISABLE_PROMPT = "1";
    };
  };
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
      obs-vkcapture
      obs-pipewire-audio-capture
    ];
  };
}

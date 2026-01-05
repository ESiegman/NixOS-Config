# modules/nixos/desktop.nix
{ pkgs, lib, config, ... }:
let wallpaper = ../../images/wallpaper.png;
in {
  services = {
    udev.enable = true;
    dbus.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "us";
      videoDrivers = [ "amdgpu" ];
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      sugarCandyNix = {
        enable = true;
        settings = {
          Background = lib.cleanSource wallpaper;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
        };
      };
    };
    pipewire = {
      audio.enable = true;
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      # settings.PasswordAuthentication = false;
      # settings.KbdInteractiveAuthentication = false;
    };
    playerctld.enable = true;
    udev.extraRules = ''
      # Arduino Nano ESP32
      SUBSYSTEM=="usb", ATTR{idVendor}=="2341", ATTR{idProduct}=="0070", MODE="0666", GROUP="dialout"
      SUBSYSTEM=="usb", ATTR{idVendor}=="2341", ATTR{idProduct}=="0071", MODE="0666", GROUP="dialout"
    '';
    tumbler.enable = true;
  };

  programs = {
    hyprland.enable = true;
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
    nm-applet.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gnome
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
    variables.XDG_RUNTIME_DIR = "/run/user/1000";
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "0";
    };
    systemPackages = with pkgs; [
      libnotify
      wofi
      brightnessctl
      wl-clipboard
      wlogout
      brightnessctl
      hyprshot
      playerctl
      mesa-demos
      glxinfo
      swaynotificationcenter
      xdg-desktop-portal
      base16-schemes
      swww
      gdk-pixbuf
      imagemagick
      ffmpegthumbnailer
      poppler
      v4l-utils
    ];
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=2 video_nr=1,10 card_label="OBS-Raw","Discord-Ready" exclusive_caps=1
  '';
  programs.obs-studio.enableVirtualCamera = true;
}

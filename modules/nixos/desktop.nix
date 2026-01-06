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
      extraConfig.pipewire."99-virtual-camera" = {
        "context.modules" = [{
          name = "libpipewire-module-v4l2-loopback";
          args = {
            "node.name" = "VTube_Virtual_Cam";
            "node.description" = "Wayland Virtual Camera";
            # exclusive_caps is required for Chromium/Discord to see it
            "device.caps" = [
              "video/x-raw,format=I420,width=1920,height=1080,framerate=60/1"
            ];
            "exclusive_caps" = true;
          };
        }];
      };
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
      VIRTUAL_ENV_DISABLE_PROMPT = "1";
      OPENCV_VIDEOIO_PRIORITY_LIST = "PIPEWIRE,V4L2";
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
      wireplumber
    ];
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

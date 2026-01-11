# hosts/laptop/apps.nix
{ pkgs, ... }:
let
  cinnamon-ui = with pkgs; [
    cinnamon-favouritemenu
    mint-cursor-themes
    mint-icon-themes
    mint-themes
    gnome-screenshot
    dconf-editor
  ];

  mobility = with pkgs; [
    acpi
    powertop
    brightnessctl
    libinput-gestures
    intel-gpu-tools
  ];

  utils = with pkgs; [
    wl-clipboard
    playerctl
    wireplumber
    gdk-pixbuf
    imagemagick
    bluez
  ];

  productivity = with pkgs; [ ];

  thumbnailers = with pkgs; [ ffmpegthumbnailer poppler ];

in {
  environment.systemPackages = cinnamon-ui ++ mobility ++ utils ++ productivity
    ++ thumbnailers;
}

# hosts/desktop/apps.nix
{ pkgs, ... }:
let
  gaming = with pkgs; [
    mangohud
    goverlay
    vkbasalt
    gamescope
    heroic
    protonup-qt
    mesa-demos
    prismlauncher
  ];

  desktop-ui = with pkgs; [
    wofi
    swaynotificationcenter
    libnotify
    swww
    wlogout
    hyprshot
    base16-schemes
  ];

  utils = with pkgs; [
    wl-clipboard
    brightnessctl
    playerctl
    wireplumber
    gdk-pixbuf
    imagemagick
    wine
    samba
    winetricks
  ];

  thumbnailers = with pkgs; [ ffmpegthumbnailer poppler ];

  workstation = with pkgs; [
    pkgsRocm.blender
    mission-center
    kdePackages.kdenlive
    gimp
    inkscape
  ];

in {
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  environment.systemPackages = gaming ++ desktop-ui ++ utils ++ thumbnailers
    ++ workstation;
}

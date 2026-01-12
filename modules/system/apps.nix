# modules/system/apps.nix
{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  terminal = with pkgs; [
    kitty
    wget
    zip
    unzip
    curl
    ueberzug
    ueberzugpp
    pay-respects
    file-roller
    btop
    ripgrep
    fd
  ];
  media = with pkgs; [ vlc pavucontrol zathura ];
  productivity = with pkgs; [ libreoffice kicad ];
in {
  programs = {
    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        fullAppDisplay
        groupSession
        shuffle
        oneko
      ];
      theme = spicePkgs.themes.sleek;
      colorScheme = "Cherry";
    };
  };
  environment.systemPackages = terminal ++ media ++ productivity;
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}

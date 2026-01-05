# modules/nixos/apps.nix
{ inputs, pkgs, ... }:
let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
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

  environment.systemPackages = with pkgs; [
    wget
    zip
    unzip
    curl

    prismlauncher

    ueberzug
    ueberzugpp
    pay-respects

    cmatrix
    cbonsai

    obs-studio

    libreoffice
    kicad

    zathura
    vlc

    pavucontrol

    wine
    samba
    winetricks
  ];

  virtualisation.docker.enable = true;
}

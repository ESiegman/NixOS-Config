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
    file-roller
    curl

    prismlauncher

    ueberzug
    ueberzugpp
    pay-respects

    cmatrix
    cbonsai

    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    })

    libreoffice
    kicad

    zathura
    vlc

    pavucontrol

    wine
    samba
    winetricks

    steam
  ];

  virtualisation.docker.enable = true;
}

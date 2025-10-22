# home/eren/default.nix
{ pkgs, ... }:
{
  #imports = lib.recursiveImport ./.;
  imports = [
    ./fastfetch.nix
    ./hyprland.nix
    ./waybar.nix
    ./neovim.nix
    ./swaync.nix
    ./wlogout.nix
    ./zed.nix
    ./firefox.nix
    ./hyprlock.nix
    ./kitty.nix
    ./starship.nix
    ./vesktop.nix
    ./wofi.nix
    ./zsh.nix
  ];
  stylix.targets = {
    zed.enable = false;
    hyprlock.enable = false;
    firefox.enable = false;
    vesktop.enable = false;
    waybar.enable = false;
  };

  home = {
    username = "eren";
    homeDirectory = "/home/eren";
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  programs = {
    home-manager.enable = true;
    eza = {
      enable = true;
      icons = "auto";
    };
    fzf.enable = true;
    bat.enable = true;
    fd = {
      enable = true;
      hidden = true;
    };
    java = {
      enable = true;
      package = pkgs.jdk;
    };
    jq.enable = true;
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    btop.enable = true;
    ripgrep.enable = true;
    firefox = {
      enable = true;
    };
  };
  services.gnome-keyring.enable = true;
}

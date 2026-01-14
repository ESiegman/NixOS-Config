{ osConfig, ... }: {
  imports = [
    ./zsh.nix
    ./starship.nix
    ./fastfetch.nix
    ./firefox.nix
    ./vesktop.nix
    ./neovim.nix
    ./kitty.nix
  ] ++ (if osConfig.networking.hostName == "desktop" then [
    ./hypr/hyprland.nix
    ./hypr/hyprlock.nix
    ./hypr/swaync.nix
    ./hypr/wofi.nix
  ] else if osConfig.networking.hostName == "laptop" then
    [ ./cinnamon.nix ]
  else
    [ ]);

  stylix.targets = {
    firefox.enable = false;
    vesktop.enable = false;
    kitty.enable = false;
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
    jq.enable = true;
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
  services.gnome-keyring.enable = true;

  home.stateVersion = "25.05";
}

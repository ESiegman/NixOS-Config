# home/eren/wofi.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      allow_images = true;
      width = "40%";
      height = "50%";
      prompt = "Search Apps...";
      normal_window = true;
      insensitive = true;
    };
  };

  stylix.targets.wofi.enable = true;
}

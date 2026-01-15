# modules/home/kde.nix
{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    panels = [{
      location = "bottom";
      widgets = [{
        name = "org.kde.plasma.kickoff";
        config = {
          icon = "nix-snowflake-white";
          alphaSort = true;
        };
      }];
    }];
  };
}

# modules/home/kde.nix
{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    panels = [{
      location = "bottom";
      widgets = [
        {
          name = "org.kde.plasma.kickoff";
          config = {
            icon = "nix-snowflake-white";
            alphaSort = true;
          };
        }
        {
          name = "org.kde.plasma.icontasks";
          config = {
            General = {
              launchers = [
                "applications:org.kde.settings.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:kitty.desktop"
                "applications:firefox.desktop"
              ];
            };
          };
        }
      ];
    }];
  };
}

# modules/home/kde.nix
{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    panels = [{
      location = "bottom";
      widgets = [
        {
          kickoff = {
            icon = "nix-snowflake-white";
            sortAlphabetically = true;
          };
        }
        {
          icontasks = {
            launchers = [
              "applications:org.kde.settings.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:kitty.desktop"
              "applications:firefox.desktop"
            ];
          };
        }
        "org.kde.plasma.marginsseparator"
      ];
    }];
  };
}

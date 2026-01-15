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
          iconTasks = {
            launchers = [
              "applications:org.kde.systemsettings.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:kitty.desktop"
              "applications:firefox.desktop"
            ];
          };
        }
        "org.kde.plasma.marginsseparator"
        {
          systemTray.items = {
            shown = [
              "org.kde.plasma.bluetooth"
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.battery"
              "org.kde.plasma.volume"
            ];
            hidden = [ "org.kde.plasma.clipboard" ];
          };
        }
        {
          digitalClock = {
            calendar.firstDayOfWeek = "sunday";
            time.format = "12h";
          };
        }
      ];
    }];
  };
}

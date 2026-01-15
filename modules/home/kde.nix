# modules/home/kde.nix
{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    panels = [
      {
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
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:kitty.desktop"
                "applications:vesktop.desktop"
                "applications:spotify.desktop"
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
      }
      {
        location = "top";
        height = 20;
        widgets = [{
          applicationTitleBar = {
            behavior = { activeTaskSource = "activeTask"; };
            layout = {
              elements = [ "windowTitle" ];
              horizontalAlignment = "left";
              showDisabledElements = "deactivated";
              verticalAlignment = "center";
            };
            overrideForMaximized.enable = false;
            titleReplacements = [{
              type = "regexp";
              originalTitle = "\\\\bDolphin\\\\b";
              newTitle = "File manager";
            }];
            windowTitle = {
              font = {
                bold = false;
                fit = "fixedSize";
                size = 12;
              };
              hideEmptyTitle = true;
              margins = {
                bottom = 0;
                left = 10;
                right = 5;
                top = 0;
              };
              source = "appName";
            };
          };
        }];
      }
    ];
  };
}

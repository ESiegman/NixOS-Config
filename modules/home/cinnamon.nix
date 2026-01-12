# modules/home/cinnamon.nix
{ pkgs, ... }: {
  dconf.settings = {
    "org/cinnamon/desktop/interface" = {
      clock-use-24h = false;
      show-battery-percentage = true;
    };

    "org/cinnamon/desktop/peripherals/touchpad" = {
      natural-scroll = true;
      tap-to-click = true;
      click-method = "fingers";
    };

    "org/cinnamon/desktop/wm/preferences" = {
      button-layout = "menu:minimize,maximize,close";
      workspace-names = [ "Main" "Dev" "Web" "Media" ];
    };

    "org/cinnamon" = {
      enabled-applets = [
        "panel1:left:0:menu@cinnamon.org"
        "panel1:left:1:show-desktop@cinnamon.org"
        "panel1:left:2:grouped-window-list@cinnamon.org"
        "panel1:right:0:systray@cinnamon.org"
        "panel1:right:1:xapp-status@cinnamon.org"
        "panel1:right:2:notifications@cinnamon.org"
        "panel1:right:3:printers@cinnamon.org"
        "panel1:right:4:removable-drives@cinnamon.org"
        "panel1:right:5:keyboard@cinnamon.org"
        "panel1:right:6:favorites@cinnamon.org"
        "panel1:right:7:network@cinnamon.org"
        "panel1:right:8:sound@cinnamon.org"
        "panel1:right:9:power@cinnamon.org"
        "panel1:right:10:calendar@cinnamon.org"
      ];
    };

    "org/cinnamon/desktop/screensaver" = {
      ask-for-password-delay = 0;
      lock-enabled = true;
    };
  };

}

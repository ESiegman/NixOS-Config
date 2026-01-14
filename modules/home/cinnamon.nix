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
        "panel1:right:5:network@cinnamon.org"
        "panel1:right:6:sound@cinnamon.org"
        "panel1:right:7:power@cinnamon.org"
        "panel1:right:8:calendar@cinnamon.org"
      ];
    };

    home.file.".config/cinnamon/spices/grouped-window-list@cinnamon.org/365.json".text = builtins.toJSON {
    "pinned-apps" = {
      "type" = "list";
      "value" = [
        "nemo.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "vesktop.desktop"
        "spotify.desktop"
      ];
    };
    # We include these to ensure Cinnamon views the file as valid
    "panel-edit-mode" = {
      "type" = "boolean";
      "value" = false;
    };
    "show-labels" = {
      "type" = "boolean";
      "value" = false;
    };
  };
}

    "org/cinnamon/desktop/screensaver" = {
      ask-for-password-delay = 0;
      lock-enabled = true;
    };
  };

}

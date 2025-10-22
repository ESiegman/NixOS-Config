# home/eren/swaync.nix
{ config, ... }:
let
  palette = config.stylix.base16Scheme;
in
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      controlCenterWidth = 500;
      controlCenterHeight = 600;
      notificationWindowWidth = 400;
      notificationIconSize = 64;
      notificationBodyImageHeight = 100;
      notificationBodyImageWidth = 200;
      timeout = 10;
      timeoutLow = 5;
      timeoutCritical = 0;
      widgets = [
        "title"
        "dnd"
        "notifications"
      ];
      widgetConfig = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
      };
    };

    style = ''
      /* Use CSS variables for a clean theme definition */
      :root {
          --background: #${palette.base00};
          --background-alt: #${palette.base01};
          --text-color: #${palette.base05};
          --border-color: #${palette.base02};
          --accent-color: #${palette.base0D};
          --success-color: #${palette.base0B};
          --warning-color: #${palette.base0A};
          --error-color: #${palette.base08};
          --font-family: "${config.stylix.fonts.sansSerif.name}";
          --border-radius: 12px;
      }

      * {
          font-family: var(--font-family), sans-serif;
          color: var(--text-color);
      }

      .control-center {
          background-color: alpha(var(--background), 0.9);
          border: 2px solid var(--border-color);
          border-radius: var(--border-radius);
      }

      .notification-row {
          outline: none;
          margin: 10px;
          padding: 0;
      }

      .notification {
          background-color: var(--background-alt);
          border: 1px solid var(--border-color);
          border-radius: var(--border-radius);
          padding: 10px;
      }

      .notification.critical {
          background-color: alpha(var(--error-color), 0.3);
          border: 1px solid var(--error-color);
      }

      .close-button {
          background-color: var(--background);
          color: var(--text-color);
          border-radius: 100%;
      }
      .close-button:hover {
          background-color: var(--error-color);
          color: var(--background);
      }

      .notification-action {
          color: var(--background);
          background-color: var(--accent-color);
          border: none;
          border-radius: 6px;
          margin: 0 5px;
          padding: 5px 10px;
      }
      .notification-action:hover {
          opacity: 0.8;
      }

      .title {
          font-size: 1.2rem;
          font-weight: bold;
      }

      .widget-dnd {
          margin: 10px;
      }
      .widget-dnd > switch {
          font-size: 0; /* Hide the text on the switch */
      }
      .widget-dnd > switch:checked {
          background-color: var(--success-color);
      }
    '';
  };
}

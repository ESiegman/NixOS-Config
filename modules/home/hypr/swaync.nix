# home/eren/swaync.nix
{ config, ... }:
let palette = config.stylix.base16Scheme;
in {
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

      widgets = [ "title" "dnd" "mpris" "volume" "notifications" ];

      widgetConfig = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = { text = "Do Not Disturb"; };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
      };
    };

    style = ''
      /* Use Stylix-derived CSS variables */
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
          background-color: alpha(var(--background), 0.95);
          border: 2px solid var(--accent-color); /* Matches your Hyprland borders */
          border-radius: var(--border-radius);
          margin: 10px;
      }

      .notification-row {
          outline: none;
          margin: 10px;
      }

      .notification {
          background-color: var(--background-alt);
          border: 1px solid var(--border-color);
          border-radius: var(--border-radius);
          padding: 10px;
          box-shadow: 0 4px 8px rgba(0,0,0,0.3);
      }

      .notification.critical {
          border: 2px solid var(--error-color);
      }

      /* MPRIS (Media Player) Styling - Matches Spicetify */
      .widget-mpris {
          background-color: var(--background-alt);
          padding: 10px;
          margin: 10px;
          border-radius: var(--border-radius);
          border: 1px solid var(--border-color);
      }

      .widget-mpris-player {
          padding: 5px;
      }

      .widget-mpris-title {
          font-weight: bold;
          font-size: 1.1rem;
      }

      .widget-mpris-subtitle {
          font-size: 0.9rem;
          opacity: 0.8;
      }

      /* Buttons & Interactions */
      .close-button {
          background-color: var(--background);
          border-radius: 100%;
          margin: 5px;
      }

      .close-button:hover {
          background-color: var(--error-color);
          color: var(--background);
      }

      .notification-action {
          color: var(--text-color);
          background-color: alpha(var(--accent-color), 0.2);
          border: 1px solid var(--accent-color);
          border-radius: 8px;
          margin: 5px;
      }

      .notification-action:hover {
          background-color: var(--accent-color);
          color: var(--background);
      }

      /* Switch (Toggle) Styling */
      .widget-dnd > switch {
          font-size: 0;
          background-color: var(--background-alt);
          border: 1px solid var(--border-color);
          border-radius: 20px;
      }

      .widget-dnd > switch:checked {
          background-color: var(--success-color);
      }

      .widget-dnd > switch slider {
          background-color: var(--text-color);
          border-radius: 20px;
          margin: 2px;
      }
    '';
  };
}

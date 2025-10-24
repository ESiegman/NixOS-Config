{
  config,
  pkgs,
  ...
}:
let
  palette = config.stylix.base16Scheme;

  toHex = hex: "#${hex}";
in
{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 6;
        height = 32;

        "modules-left" = [
          "custom/launcher"
          "hyprland/workspaces"
        ];
        "modules-center" = [ "hyprland/window" ];
        "modules-right" = [
          "custom/swaync"
          "pulseaudio"
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "clock"
          "tray"
          "custom/power"
        ];

        "custom/launcher" = {
          format = "";
          tooltip-format = "Launch Wofi";
          on-click = "wofi --show drun";
        };

        "hyprland/workspaces" = {
          format = "{name} {icon}";
          format-icons = {
            "default" = "";
            "active" = "";
          };
          "on-click" = "activate";
          "active-only" = false;
          "all-outputs" = true;
          "swap-icon-label" = false;
        };

        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) - VSCodium" = "VSCodium";
            "(.*) - Visual Studio Code" = "VS Code";
          };
          max-length = 50;
        };

        "custom/swaync" = {
          format = "";
          tooltip = false;
          on-click = "swaync-client -t";
          exec = "swaync-client -c";
          exec-if = "which swaync-client";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            headphone = "";
            default = [
              ""
              ""
              "󰕾"
              "󰕾"
              "󰕾"
              ""
              ""
              ""
            ];
          };
        };
        "bluetooth" = {
          format = " {}";
          format-disabled = "";
          on-click = "blueman-manager";
        };
        "network" = {
          format-wifi = "{essid} {percent}% ";
          format-ethernet = "Connected  ";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click = "nm-applet";
        };
        "cpu" = {
          format = " {usage}%";
          tooltip-format = "CPU: {usage}% @ {avg_frequency}GHz";
          interval = 2;
        };

        "memory" = {
          format = " {used:0.1f}G";
          tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
          interval = 2;
        };

        "clock" = {
          format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%A, %B %d}</big>";
        };

        "tray" = {
          icon-size = 18;
          spacing = 8;
        };

        "custom/power" = {
          format = "";
          tooltip-format = "Logout Menu";
          on-click = "wlogout";
        };
      };
    };

    style = ''
      * {
        font-family: ${
          config.stylix.fonts.monospace.name or config.stylix.fonts.monospace or "monospace"
        };
        font-size: 12px;
        min-height: 0;
      }

      #waybar {
        border: 2px solid ${toHex palette.base02};
        border-radius: 12px;
        background-color: alpha(${toHex palette.base00}, 0.8);
        margin: 8px 12px;
        padding: 0 20px;
      }

      #custom-launcher {
        padding: 0 4px;
        margin-left: 12px;
        margin-right: 8px;
      }

      #workspaces {
        margin-right: 4px;
      }

      #workspaces button {
        padding: 0 8px;
        margin: 0 2px;
        border-radius: 8px;
        transition: background 0.2s ease, color 0.2s ease;
      }

      #workspaces button.active {
        background-color: alpha(${toHex palette.base0D}, 0.2);
        color: ${toHex palette.base0D};
      }

      #modules-left,
      #modules-right {
        padding: 0 0px;
      }

      #custom-power {
        margin-right: 16px;
        margin: 0 4px;
        padding: 4px 8px;
      }

      #tray,
      #clock,
      #memory,
      #cpu,
      #pulseaudio,
      #bluetooth,
      #network,
      #custom-swaync {
        margin: 0 4px;
        padding: 4px 8px;
        border-radius: 8px;
        transition: background 0.2s ease, color 0.2s ease;
      }

      #tray:hover,
      #bluetooth,
      #network,
      #custom-launcher:hover,
      #custom-power:hover,
      #custom-swaync:hover {
        background-color: alpha(${toHex palette.base0D}, 0.13);
        color: ${toHex palette.base0D};
      }

      #custom-gpu {
        color: ${toHex palette.base0C};
      }

      #cpu {
        color: ${toHex palette.base0B};
      }

      #memory {
        color: ${toHex palette.base0A};
      }

      #clock {
        color: ${toHex palette.base0D};
      }

      #custom-power {
        color: ${toHex palette.base08};
      }
    '';
  };
}

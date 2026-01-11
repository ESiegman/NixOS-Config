{ config, pkgs, ... }:
let palette = config.stylix.base16Scheme;
in {
  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "p";
      }
    ];

    style = ''
      /* Reset and base styles */
      * {
        background-image: none;
        box-shadow: none;
        font-family: "${config.stylix.fonts.sansSerif.name}";
      }

      window {
        background-color: rgba(${
          (palette.base00)
        }, 0.85); /* Uses Stylix background */
      }

      button {
        border-radius: 12px;
        margin: 10px;
        border-color: #${palette.base0D}; /* Primary Accent (Pink/Blue) */
        text-decoration-color: #${palette.base05};
        color: #${palette.base05};
        background-color: #${palette.base01};
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        transition: all 0.3s cubic-bezier(.55,0.055,.675,.19);
      }

      button:focus, button:active, button:hover {
        background-color: #${palette.base02};
        border-color: #${palette.base0B}; /* Changes to Green on hover */
        outline-style: none;
      }

      /* Icons for buttons - Wlogout expects these labels */
      #lock { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png")); }
      #logout { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png")); }
      #suspend { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png")); }
      #hibernate { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png")); }
      #reboot { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")); }
      #shutdown { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")); }
    '';
  };
}

{ config, pkgs, ... }:
let
  palette = config.stylix.base16Scheme;

in
{
  programs.wlogout = {
    enable = true;

    layout = [
      { label = "lock"; action = "hyprlock"; text = "Lock"; keybind = "l"; }
      { label = "logout"; action = "hyprctl dispatch exit"; text = "Logout"; keybind = "e"; }
      { label = "suspend"; action = "systemctl suspend"; text = "Suspend"; keybind = "s"; }
      { label = "hibernate"; action = "systemctl hibernate"; text = "Hibernate"; keybind = "h"; }
      { label = "reboot"; action = "systemctl reboot"; text = "Reboot"; keybind = "r"; }
      { label = "shutdown"; action = "systemctl poweroff"; text = "Shutdown"; keybind = "p"; }
    ];

    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(30, 30, 46, 0.90);
      }

      button {
        border-radius: 0;
        border-color: #f5c2e7;
        text-decoration-color: #cdd6f4;
        color: #cdd6f4;
        background-color: #181825;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:focus, button:active, button:hover {
        background-color: rgb(48, 50, 66);
        outline-style: none;
      }
    '';
  };
}

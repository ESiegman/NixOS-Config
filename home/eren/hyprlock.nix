# home/eren/hyprlock.nix
{ config, ... }:
let
  palette = config.stylix.base16Scheme;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = {
        path = "${config.stylix.image}";
        blur_passes = 3;
        blur_size = 8;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        size = "250, 50";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        inner_color = "rgba(${palette.base00}99)";
        font_color = "rgb(${palette.base05})";
        fade_on_empty = false;
        placeholder_text = "<i>Password...</i>";
        hide_input = false;
        rounding = 15;
        position = "0, -80";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "cmd[update:1000] echo \"<b><big>$(date \"+%I:%M %p\")</big></b>\"";
          color = "rgb(${palette.base05})";
          font_size = 90;
          position = "0, 80";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"$(date \"+%A, %B %d\")\"";
          color = "rgb(${palette.base05})";
          font_size = 25;
          position = "0, -40";
          halign = "center";
          valign = "bottom";
        }
        {
          text = "Locked";
          color = "rgb(${palette.base05})";
          font_size = 18;
          position = "0, 20";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}

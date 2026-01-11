# home/eren/hyprlock.nix
{ config, ... }:
let palette = config.stylix.base16Scheme;
in {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = {
        path = "${config.stylix.image}";
        blur_passes = 3;
        blur_size = 8;
        noise = 1.17e-2;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        size = "280, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;

        inner_color = "rgba(${palette.base00}99)";
        font_color = "rgb(${palette.base05})";

        check_color = "rgb(${palette.base0B})";
        fail_color = "rgb(${palette.base08})";
        outer_color = "rgb(${palette.base0D})";

        fade_on_empty = false;
        placeholder_text = "<i>Enter Password...</i>";
        hide_input = false;
        rounding = 15;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "$TIME";
          color = "rgb(${palette.base05})";
          font_size = 120;
          font_family = config.stylix.fonts.monospace.name;
          position = "0, 100";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
        }
        {
          text = ''cmd[update:43200000] echo "$(date +'%A, %d %B')"'';
          color = "rgba(${palette.base05}cc)";
          font_size = 24;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 10";
          halign = "center";
          valign = "center";
        }
        {
          text =
            "Welcome back, <span foreground='##${palette.base0D}'>$USER</span>";
          color = "rgb(${palette.base05})";
          font_size = 18;
          font_family = config.stylix.fonts.sansSerif.name;
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}

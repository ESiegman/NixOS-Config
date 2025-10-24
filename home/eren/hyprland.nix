# home/eren/stylix.nix
{
  lib,
  config,
  ...
}:
let
  palette = config.stylix.base16Scheme;
  toRgba = hex: "rgba(${hex}FF)";
  mod = "SUPER";
  wallpaper = ../../images/wallpaper.png;
in
{
  stylix.targets.hyprland.enable = false;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
  };
  wayland.windowManager.hyprland.settings = {

    monitor = ",highrr,auto,1";
    env = [ "XCURSOR_SIZE,24" ];

    exec-once = [
      "waybar"
      "swww-daemon"
      "swww img ${wallpaper}"
      "nm-applet"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      layout = "dwindle";
      allow_tearing = true;

      "col.active_border" = "rgba(${palette.base0D}FF) rgba(${palette.base0C}FF) 45deg";
      "col.inactive_border" = toRgba palette.base01;
    };

    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };

      shadow = {
        enabled = true;
        range = 8;
        render_power = 3;
        color = "rgba(00000066)";
      };
    };

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    "$mod" = "SUPER";
    bind = [
      "${mod}, C, killactive,"
      "${mod}, T, fullscreen"
      "${mod}, V, togglefloating,"
      "${mod}, J, togglesplit,"

      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

      ", Print, exec, sh -c 'hyprshot -m region output --clipboard-only'"
      "Shift, Print, exec, sh -c 'hyprshot -m window output --clipboard-only'"

      "${mod}, S, togglespecialworkspace, magic"
      "${mod} SHIFT, S, movetoworkspace, special:magic"

      "${mod}, Q, exec, kitty"
      "${mod}, E, exec, thunar"
      "${mod}, F, exec, wofi --show drun"
      "${mod}, L, exec, swaync-client -t -sw"
      "${mod}, W, exec, wlogout"
      "${mod}, B, exec, firefox"
      "${mod} SHIFT, B, exec, chromium"
      "${mod}, M, exec, spotify"
      "${mod}, D, exec, vesktop"
    ]
    ++ (builtins.concatLists (
      builtins.genList (
        i:
        let
          ws = i + 1;
        in
        [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]
      ) 9
    ));

    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}

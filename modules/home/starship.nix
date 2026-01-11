# home/eren/starship.nix
{ config, lib, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = let
      palette = config.stylix.base16Scheme;

      color_bg1 = "#${palette.base01}";
      color_bg3 = "#${palette.base03}";
      color_bg4 = "#${palette.base02}";
      color_accent = "#${palette.base0D}";
      color_sep = "#${palette.base04}";

      color_text_dark = "#${palette.base01}";
      color_text_main = "#${palette.base05}";
      color_text_light = "#${palette.base07}";
    in {
      add_newline = true;

      format = lib.concatStrings [
        "[░▒▓](${color_sep})"
        "[  ](bg:${color_sep} fg:${color_text_dark})"
        "[](bg:${color_accent} fg:${color_sep})"
        "$directory"
        "[](fg:${color_accent} bg:${color_bg3})"
        "$git_branch"
        "$git_status"
        "[](fg:${color_bg3} bg:${color_bg4})"
        "$c$cpp$python$golang$rust$nodejs$php"
        "$nix_shell"
        "[](fg:${color_bg4} bg:${color_bg1})"
        "$time"
        "[ ](fg:${color_bg1})"
        ''

          $character''
      ];

      directory = {
        style = "fg:${color_text_light} bg:${color_accent}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
          "NixOS-Config" = "❄️ ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:${color_bg3}";
        format =
          "[[ $symbol $branch ](fg:${color_accent} bg:${color_bg3})]($style)";
      };

      git_status = {
        style = "bg:${color_bg3}";
        format =
          "[[($all_status$ahead_behind )](fg:${color_accent} bg:${color_bg3})]($style)";
      };

      nix_shell = {
        symbol = " ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol \\($name\\) ](fg:#${palette.base0B} bg:${color_bg4})]($style)";
      };

      character = {
        success_symbol = "[󱞩](bold #${palette.base0B})";
        error_symbol = "[󱞩](bold #${palette.base08})";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:${color_bg1}";
        format = "[[  $time ](fg:${color_text_main} bg:${color_bg1})]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol($version) ](fg:${color_accent} bg:${color_bg4})]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol($version) ](fg:${color_accent} bg:${color_bg4})]($style)";
      };

      python = {
        symbol = " ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol($version) ](fg:${color_accent} bg:${color_bg4})]($style)";
      };

      rust = {
        symbol = " ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol($version) ](fg:${color_accent} bg:${color_bg4})]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol($version) ](fg:${color_accent} bg:${color_bg4})]($style)";
      };

      nodejs = {
        symbol = "󰎙 ";
        style = "bg:${color_bg4}";
        format =
          "[[ $symbol($version) ](fg:${color_accent} bg:${color_bg4})]($style)";
      };

    };
  };
}

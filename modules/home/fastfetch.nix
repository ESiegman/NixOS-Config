# home/eren/fastfetch.nix
{ config, ... }:
let palette = config.stylix.base16Scheme;
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos";
        color."1" = "#${palette.base05}";
      };

      display = { separator = " "; };

      modules = [
        {
          type = "os";
          key = "  NixOS";
          keyColor = "#${palette.base0D}";
        }

        {
          type = "custom";
          format =
            "┌──────────────────────────Software──────────────────────────┐";
          color = "#${palette.base0B}";
        }
        {
          type = "shell";
          key = "  Shell";
          keyColor = "#${palette.base0B}";
        }
        {
          type = "terminal";
          key = "  Terminal";
          keyColor = "#${palette.base0B}";
        }
        {
          type = "terminalfont";
          key = "  Font";
          keyColor = "#${palette.base0B}";
        }
        {
          type = "packages";
          key = "  Packages";
          keyColor = "#${palette.base0B}";
        }
        {
          type = "wm";
          key = " 󰧨 WM";
          keyColor = "#${palette.base0B}";
        }
        {
          type = "custom";
          format =
            "└────────────────────────────────────────────────────────────┘";
          color = "#${palette.base0B}";
        }

        {
          type = "custom";
          format =
            "┌───────────────────────────Hardware─────────────────────────┐";
          color = "#${palette.base0C}";
        }
        {
          type = "display";
          key = "  Display";
          keyColor = "#${palette.base0C}";
        }
        {
          type = "cpu";
          key = "  CPU";
          keyColor = "#${palette.base0C}";
        }
        {
          type = "gpu";
          key = "  GPU";
          keyColor = "#${palette.base0C}";
        }
        {
          type = "memory";
          key = "  RAM";
          keyColor = "#${palette.base0C}";
        }
        {
          type = "disk";
          key = "  Disk";
          keyColor = "#${palette.base0C}";
        }
        {
          type = "custom";
          format =
            "└────────────────────────────────────────────────────────────┘";
          color = "#${palette.base0C}";
        }
        { "type" = "break"; }
        {
          type = "colors";
          paddingLeft = 15;
        }
      ];
    };
  };
}

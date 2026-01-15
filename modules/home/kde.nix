# modules/home/kde.nix
{ pkgs, ... }: {
  programs.plasma = {
    enable = true;
    configFile."kdeglobals"."General"."TerminalApplication" = "kitty";
    configFile."kdeglobals"."General"."TerminalService" = "kitty.desktop";
  };
}

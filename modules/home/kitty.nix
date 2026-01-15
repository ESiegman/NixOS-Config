# home/eren/kitty.nix
{ pkgs, osConfig, ... }: {
  programs.kitty = {
    enable = true;
    package = let
      isLaptop = (osConfig.networking.hostName or "") == "laptop";
      baseKitty = pkgs.kitty;
    in if isLaptop then
      pkgs.writeShellScriptBin "kitty" ''
        #!/bin/sh
        exec nvidia-offload ${baseKitty}/bin/kitty "$@"
      ''
    else
      baseKitty;

    settings = {
      background_opacity = "0.9";

      sync_to_monitor = "yes";
      repaint_delay = 8;
      input_delay = 2;

      scrollback_lines = 10000;
      scrollback_pager = "${pkgs.bat}/bin/bat --paging=always";

      window_padding_width = 15;
      confirm_os_window_close = 0;

      detect_urls = true;
      enable_audio_bell = false;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_font_style = "bold";

      shell_integration = "enabled";
      term = "xterm-kitty";

      linux_display_server = "wayland";
    };
  };
}

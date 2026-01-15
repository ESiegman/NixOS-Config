# home/eren/kitty.nix
{ pkgs, osConfig, ... }: {
  programs.kitty = {
    enable = true;
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

  home.file.".local/bin/kitty" = {
    executable = true;
    text = ''
      #!/bin/sh
      exec /run/current-system/sw/bin/nvidia-offload ${pkgs.kitty}/bin/kitty "$@"
    '';
    enable = (osConfig.networking.hostName or "") == "laptop";
  };
  home.sessionPath = [ "$HOME/.local/bin" ];
}

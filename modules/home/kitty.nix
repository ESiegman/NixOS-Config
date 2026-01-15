# home/eren/kitty.nix
{ pkgs, config, ... }: {
  programs.kitty = {
    enable = true;
    package = if config.networking.hostName == "laptop" then
      (pkgs.symlinkJoin {
        name = "kitty";
        paths = [ pkgs.kitty ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/kitty \
            --set __NV_PRIME_RENDER_OFFLOAD 1 \
            --set __GLX_VENDOR_LIBRARY_NAME nvidia \
            --set VK_ICD_FILENAMES /run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json
        '';
      })
    else
      pkgs.kitty;
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

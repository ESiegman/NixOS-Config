# home/eren/kitty.nix
{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      detect_urls = true;
      enable_audio_bell = false;
      tab_bar_style = "powerline";
      term = "xterm-kitty";
      hardware_acceleration = "yes";
    };
  };
}

# home/eren/zed.nix
{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ 
      "nix" 
      "Carbonfox" 
      "Colored Zed Icons Theme" 
      "C#" 
      "Dockerfile" 
      "HTML" 
      "LaTeX" 
      "XML" 
      "Rainbow CSV"
      "NeoCMake"
      "Verilog"
      "Java"
    ];
    userSettings = {
      icon_theme = "Colored Zed Icons Theme Dark";
      theme = {
        mode = "dark";
        light = "One Dark";
        dark = "Carbonfox";
      };
      show_edit_predictions = false;
      vim_mode = false;
      ui_font_size = 16;
      buffer_font_size = 15;
    };
  };
}

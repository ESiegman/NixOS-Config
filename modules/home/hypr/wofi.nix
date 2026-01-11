{ ... }: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = "35%";
      height = "45%";
      always_parse_args = true;
      show_all = false;
      print_command = true;
      layer = "overlay";
      insensitive = true;
      prompt = "   Search Apps...";
      allow_images = true;
      image_size = 24;
      display_generic = true;
      location = "center";
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
    };
  };

  stylix.targets.wofi.enable = true;
}

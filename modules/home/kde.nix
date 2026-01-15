# modules/home/kde.nix
{ pkgs, ... }: {
  programs.plasma = { enable = true; 
    panels = {
      {
        location = "bottom";
        widgets = [

        ];
      }
    };
  };
}

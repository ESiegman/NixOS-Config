{ inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        lsp.enable = true;
        languages = {
	  enableTreesitter = true;
	  nix.enable = true;
	};
	autocomplete.nvim-cmp.enable = true;
	telescope.enable = true;
	statusline.lualine.enable = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
      };
    };
  };
}


return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		version = false,
		build = ":TSUpdate",
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				"c",
				"cpp",
				"rust",
				"python",
				"yaml",
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"astro",
				"css",
				"html",
				"json",
				"nix",
				"bash",
				"markdown",
				"markdown_inline",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").compilers = { "gcc" }

			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

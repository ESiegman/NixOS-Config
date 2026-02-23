-- lua/plugins/treesitter.lua
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local parsers = {
				"bash",
				"c",
				"cpp",
				"lua",
				"python",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"regex",
				"nix",
			}

			pcall(require("nvim-treesitter").install, parsers)

			require("nvim-treesitter.configs").setup({
				ensure_installed = parsers,

				auto_install = false,

				highlight = {
					enable = true,
				},

				indent = {
					enable = true,
				},
			})
		end,
	},
}

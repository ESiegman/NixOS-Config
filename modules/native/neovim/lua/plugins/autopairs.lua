-- lua/plugins/autopairs.lua
return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				python = { "string" },
				cpp = { "string" },
			},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
	},
}

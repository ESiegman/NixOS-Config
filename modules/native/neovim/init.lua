local lib = require("lib")

lib.setup({
	g = {
		mapleader = " ",
		maplocalleader = "\\",
		have_nerd_font = true,
	},
	opt = {
		number = true,
		relativenumber = true,
		tabstop = 2,
		shiftwidth = 2,
		expandtab = true,
		scrolloff = 8,
		ignorecase = true,
	},
	maps = {
		{ "n", "<leader>w", "<cmd>write<cr>", { desc = "Save File" } },
		{ "n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save and Quit" } },
		{ "n", "<leader>q", "<cmd>confirm quit<cr>", { desc = "Quit (with confirmation)" } },
	},
	autocmds = {
		{
			event = "BufWritePre",
			desc = "Formate Buffer on Save",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		},
	},
	commands = {
		{
			name = "Reloader",
			command = function()
				dofile(vim.env.MYVIMRC)
				print("Config reloaded!")
			end,
			opts = { desc = "Reload main config file" },
		},
	},
})

require("config.lazy")

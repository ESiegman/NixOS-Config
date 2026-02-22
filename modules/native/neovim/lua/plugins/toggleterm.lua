-- lua/plugins/toggleterm.lua
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 20,
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		persist_mode = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Horizontal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal Vertical" },
		{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		{ "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", desc = "Toggle All Terminals" },
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			callback = function()
				local map_opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], map_opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], map_opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], map_opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], map_opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], map_opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], map_opts)
			end,
		})
	end,
}

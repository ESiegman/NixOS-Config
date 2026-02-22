-- lua/plugins/bufferline.lua
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
		keys = {
			{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "<A-h>", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer left" },
			{ "<A-l>", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer right" },

			{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
			{ "<leader>bn", "<cmd>enew<cr>", desc = "New Empty Buffer" },

			{
				"<leader>bc",
				function()
					Snacks.bufdelete()
				end,
				desc = "Close Buffer (Safe)",
			},
		},
	},
}

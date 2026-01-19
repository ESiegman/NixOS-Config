return {

	"folke/which-key.nvim",
	event = "VeryLazy",

	config = function()
		local wk = require("which-key")

		wk.setup({

			winblend = 0,

			win = {
				border = "single",
			},
			layout = {
				spacing = 5,
				align = "left",
			},

			replace = {
				["<leader>"] = "SPC",
			},

			skip_check = true,
		})

		local mappings = {
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>f", group = "[F]ile" },
			{ "<leader>h", group = "[H]ex" },
			{ "<leader>l", group = "[L] CMake" },
			{ "<leader>m", group = "[M]usic" },
			{ "<leader>o", group = "[O]verseer" },
			{ "<leader>p", group = "[P]erf" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]erminal" },
		}

		wk.add(mappings, { mode = "n" })
	end,
}

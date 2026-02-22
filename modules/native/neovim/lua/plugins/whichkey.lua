-- lua/plugins/whichkey.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		win = {
			border = "rounded",
		},
		layout = {
			spacing = 5,
			align = "left",
		},
		icons = {
			mappings = true,
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		wk.add({
			{ "<leader>b", group = "[B]uffer" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>n", group = "[N]otifications" },
			{ "<leader>o", group = "[O]verseer/Tasks" },
			{ "<leader>p", group = "[P]erf/rofiling" },
			{ "<leader>s", group = "[S]earch (Telescope)" },
			{ "<leader>t", group = "[T]erminal" },
			{ "<leader>z", group = "[Z]en Mode" },
		})
	end,
}

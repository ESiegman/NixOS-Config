return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"orjangj/neotest-ctest",
		},
		opts = {
			signature = {
				active = true,
				max_width = 100,
			},
			summary = {
				result_output = "floating",
			},
		},
		config = function(_, opts)
			opts.adapters = {
				require("neotest-ctest"),
			}
			require("neotest").setup(opts)
		end,
	},
}

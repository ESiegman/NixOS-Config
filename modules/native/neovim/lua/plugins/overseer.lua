return {
	{
		"stevearc/overseer.nvim",
		lazy = false,
		opts = {
			templates = { "builtin", "user" },
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
		},
		keys = {
			{ "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
			{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Task" },
			{ "<leader>ob", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
		},
	},
}

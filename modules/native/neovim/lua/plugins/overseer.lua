-- lua/plugins/overseer.lua
return {
	{
		"stevearc/overseer.nvim",
		lazy = false,
		opts = {
			templates = { "builtin", "user" },
			task_list = {
				direction = "bottom",
				min_height = 15,
				max_height = 15,
				default_detail = 1,
				binding_help = true,
			},
			form = { border = "rounded" },
			confirm = { border = "rounded" },
			task_win = { border = "rounded" },
		},
		keys = {
			{ "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
			{ "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Task" },
			{ "<leader>ob", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
			{ "<leader>oc", "<cmd>OverseerBuild<cr>", desc = "Build Task" },
		},
		config = function(_, opts)
			local overseer = require("overseer")
			overseer.setup(opts)

			overseer.add_template_hook({ module = "^builtin" }, function(task_defn, util)
				task_defn.on_init = function(task)
					overseer.open({ enter = false })
				end
			end)
		end,
	},
}

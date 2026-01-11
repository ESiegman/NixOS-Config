return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				enabled = true,
				preset = {
					header = [[
  ██╗   ██╗██████╗      ██████╗  █████╗ ███████╗
  ██║   ██║██╔══██╗    ██╔════╝ ██╔══██╗██╔════╝
██║   ██║██████╔╝    ██║  ███╗███████║█████╗
██║   ██║██╔══██╗    ██║   ██║██╔══██║██╔══╝
  ╚██████╔╝██║  ██║    ╚██████╔╝██║  ██║███████╗
    ╚═════╝ ╚═╝  ╚═╝     ╚═════╝ ╚═╝  ╚═╝╚══════╝

                    ]],
				},
			},
			dim = { enabled = true },
			explorer = { enabled = true },
			notifier = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			zen = { enabled = true },
		},
		keys = {
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
		},
	},
}

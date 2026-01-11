return {
	{
		"AntonVanAssche/music-controls.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		opts = {
			default_player = "spotify",
		},

		keys = {
			{ "<leader>mp", "<cmd>MPlay<cr>", desc = "Music: Play/Pause" },

			{ "<leader>mf", "<cmd>MNext<cr>", desc = "Music: Next" },
			{ "<leader>mb", "<cmd>MPrev<cr>", desc = "Music: Previous" },
		},
	},
}

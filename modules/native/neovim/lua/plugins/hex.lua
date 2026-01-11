return {
	{
		"RaafatTurki/hex.nvim",
		lazy = false,
		config = function()
			require("hex").setup()
		end,
		keys = {
			{
				"<leader>ht",
				function()
					require("hex").toggle()
				end,
				desc = "Hex: Toggle View",
			},

			{
				"<leader>hd",
				function()
					require("hex").dump()
				end,
				desc = "Hex: Dump View",
			},

			{
				"<leader>ha",
				function()
					require("hex").assemble()
				end,
				desc = "Hex: Assemble View",
			},
		},
	},
}

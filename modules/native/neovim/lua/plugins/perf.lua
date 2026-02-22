-- nvim lua/plugins/perf.lua
return {
	"t-troebst/perfanno.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{
			"<leader>pr",
			function()
				local cmd = vim.fn.input("Perf command: ", "perf record -g -- ./")
				if cmd ~= "" then
					vim.cmd("!" .. cmd)
				end
			end,
			desc = "Run Perf Record",
		},
		{ "<leader>pa", "<cmd>PerfAnnotate<cr>", desc = "Perf Annotate" },
		{ "<leader>pt", "<cmd>PerfAnnotateToggle<cr>", desc = "Perf Toggle" },
		{ "<leader>pl", "<cmd>PerfLoadFlat<cr>", desc = "Perf Load Flat" },
		{ "<leader>pc", "<cmd>PerfLoadCallGraph<cr>", desc = "Perf Load CallGraph" },
		{ "<leader>pn", "<cmd>PerfHottestLines<cr>", desc = "Perf Hottest Lines" },
		{ "<leader>ps", "<cmd>PerfHottestSymbols<cr>", desc = "Perf Hottest Symbols" },
		{
			"<leader>p]",
			function()
				require("perfanno").next_hotspot()
			end,
			desc = "Perf Next Hotspot",
		},
		{
			"<leader>p[",
			function()
				require("perfanno").prev_hotspot()
			end,
			desc = "Perf Prev Hotspot",
		},
	},
	opts = {
		line_highlights = true,
		vt_highlight = true,
		highlights = {
			cold = "Comment",
			medium = "WarningMsg",
			hot = "Error",
		},
		thresholds = {
			cold = 0.2,
			medium = 0.5,
			hot = 0.8,
		},
		formats = {
			c = {
				fmt = function(_, samples)
					return string.format("🔥 %d", samples)
				end,
				highlight = "Comment",
			},
			cpp = {
				fmt = function(_, samples)
					return string.format("🔥 %d", samples)
				end,
				highlight = "Comment",
			},
		},
	},
	config = function(_, opts)
		local perfanno = require("perfanno")
		perfanno.setup(opts)

		local ok, telescope = pcall(require, "telescope")
		if ok then
			telescope.load_extension("perfanno")
		end
	end,
}

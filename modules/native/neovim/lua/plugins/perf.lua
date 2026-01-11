return {
	"t-troebst/perfanno.nvim",
	opts = {
		-- Line highlights
		line_highlights = true,
		vt_highlight = true,

		-- Annotation formats
		formats = {
			rust = {
				fmt = function(line, samples)
					return string.format("%d", samples)
				end,
				highlight = "Comment",
			},
			c = {
				fmt = function(line, samples)
					return string.format("%d", samples)
				end,
				highlight = "Comment",
			},
			cpp = {
				fmt = function(line, samples)
					return string.format("%d", samples)
				end,
				highlight = "Comment",
			},
		},
	},
	keys = {
		{
			"<leader>pr",
			function()
				local cmd = vim.fn.input("Perf command: ", "perf record -g ")
				if cmd ~= "" then
					vim.cmd("!" .. cmd)
				end
			end,
			desc = "Run Perf Record",
		},
		-- Toggle annotations
		{ "<leader>pa", "<cmd>PerfAnnotate<cr>", desc = "Perf Annotate" },
		{ "<leader>pt", "<cmd>PerfAnnotateToggle<cr>", desc = "Perf Toggle" },
		{ "<leader>pl", "<cmd>PerfLoadFlat<cr>", desc = "Perf Load Flat" },
		{ "<leader>pc", "<cmd>PerfLoadCallGraph<cr>", desc = "Perf Load CallGraph" },

		-- Navigation
		{ "<leader>pn", "<cmd>PerfHottestLines<cr>", desc = "Perf Hottest Lines" },
		{ "<leader>ps", "<cmd>PerfHottestSymbols<cr>", desc = "Perf Hottest Symbols" },
		{ "<leader>pg", "<cmd>PerfHottestCallersSelection<cr>", desc = "Perf Hottest Callers", mode = "v" },

		-- Cycle through hotspots
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
			desc = "Perf Previous Hotspot",
		},
	},
	config = function(_, opts)
		local perfanno = require("perfanno")
		local util = require("perfanno.util")

		-- Default options
		local default_opts = {
			line_highlights = opts.line_highlights or true,
			vt_highlight = opts.vt_highlight or true,

			-- Highlight groups
			highlights = {
				cold = "Comment",
				medium = "WarningMsg",
				hot = "Error",
			},

			-- Thresholds for highlighting (percentage of max samples)
			thresholds = {
				cold = 0.2,
				medium = 0.5,
				hot = 0.8,
			},
		}

		-- Merge user opts with defaults
		opts = vim.tbl_deep_extend("force", default_opts, opts)

		perfanno.setup(opts)

		-- Telescope integration
		local has_telescope, telescope = pcall(require, "telescope")
		if has_telescope then
			telescope.load_extension("perfanno")
		end
	end,
}

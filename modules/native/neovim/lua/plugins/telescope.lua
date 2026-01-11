return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		-- File pickers
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Find Word" },

		-- Git pickers
		{ "<leader>sc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>ss", "<cmd>Telescope git_status<cr>", desc = "Git Status" },

		-- LSP picker
		{ "<leader>sd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
		{ "<leader>si", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP Implementations" },
		{ "<leader>sy", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },

		-- Other pickers
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
		{ "<leader>sq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
		{ "<leader>st", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
	},
	opts = {
		defaults = {
			prompt_prefix = " ",
			selection_caret = " ",
			path_display = { "truncate" },
			file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<C-x>"] = "delete_buffer",
				},
				n = {
					["q"] = "close",
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
				previewer = false,
				hidden = true,
			},
			buffers = {
				theme = "dropdown",
				previewer = false,
				initial_mode = "normal",
				mappings = {
					i = {
						["<C-d>"] = "delete_buffer",
					},
					n = {
						["dd"] = "delete_buffer",
					},
				},
			},
			git_branches = {
				theme = "dropdown",
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		opts.defaults.mappings.i["<C-q>"] = actions.send_to_qflist + actions.open_qflist
		opts.defaults.mappings.n["<C-q>"] = actions.send_to_qflist + actions.open_qflist

		telescope.setup(opts)
	end,
}

return {
	{
		"neovim/nvim-lspconfig",
		version = "^0.11",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local servers = {
				"clangd",
				"lua_ls",
				"nil_ls",
				"rust_analyzer",
				"pyright",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"astro",
				"bashls",
				"yamlls",
				"marksman",
			}

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				underline = true,
				virtual_text = { spacing = 4, prefix = "●" },
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})

			for _, name in ipairs(servers) do
				vim.lsp.config(name, {
					capabilities = capabilities,
					on_new_config = name == "clangd" and function(new_config)
						new_config.cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							"--header-insertion=iwyu",
							"--query-driver=/nix/store/*",
						}
					end or nil,
				})

				vim.lsp.enable(name)
			end
		end,
	},
}

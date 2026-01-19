return {
	{
		"neovim/nvim-lspconfig",
		version = "^0.11",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
						"--query-driver=/nix/store/*",
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { library = { vim.env.VIMRUNTIME } },
						},
					},
				},
			}

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				underline = true,
				virtual_text = true,
				signs = true,
				update_in_insert = true,
			})

			for server_name, server_config in pairs(servers) do
				local config_mod = require("lspconfig.configs." .. server_name)
				local final_config = vim.tbl_deep_extend("force", config_mod.default_config, server_config, {
					capabilities = capabilities,
					single_file_support = true,
				})

				vim.lsp.config(server_name, final_config)
				vim.lsp.enable(server_name)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					vim.notify("LSP Attached: " .. client.name)
				end,
			})
		end,
	},
}

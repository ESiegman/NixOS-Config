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
				nil_ls = {},
				rust_analyzer = {},
				pyright = {},
				ts_ls = {},
				html = {},
				cssls = {},
				jsonls = {},
				astro = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								checkThirdParty = false,
								library = { vim.env.VIMRUNTIME },
							},
						},
					},
				},
				bashls = {},
				yamlls = {},
				marksman = {},
			}

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				underline = true,
				virtual_text = { spacing = 4, prefix = "●" },
				signs = true,
				update_in_insert = true,
				severity_sort = true,
			})

			for server_name, server_config in pairs(servers) do
				local config_mod = require("lspconfig.configs." .. server_name)

				local final_config = vim.tbl_deep_extend("force", config_mod.default_config, server_config, {
					capabilities = capabilities,
					root_dir = config_mod.default_config.root_dir or function(fname)
						return vim.fs.dirname(
							vim.fs.find(
								{ ".git", "compile_commands.json", "flake.nix" },
								{ path = fname, upward = true }
							)[1]
						) or vim.uv.cwd()
					end,
				})

				vim.lsp.config(server_name, final_config)
				vim.lsp.enable(server_name)
			end
		end,
	},
}

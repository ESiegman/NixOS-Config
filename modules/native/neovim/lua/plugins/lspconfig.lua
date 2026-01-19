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
						"--query-driver=" .. (vim.env.CPLUS_INCLUDE_PATH or ""):gsub(":", ","),
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
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
								},
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
				virtual_text = {
					spacing = 4,
					prefix = "●",
				},
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})

			local lspconfig = require("lspconfig")
			for server_name, config in pairs(servers) do
				config.capabilities = capabilities
				lspconfig[server_name].setup(config)
			end
		end,
	},
}

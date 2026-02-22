-- lua/plugins/lspconfig.lua
return {
	{
		"neovim/nvim-lspconfig",
		version = "^0.11",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.diagnostic.config({
				underline = true,
				virtual_text = { spacing = 4, prefix = "●" },
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})

			local servers = {
				bashls = {},
				pyright = {},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
			}

			for name, opts in pairs(servers) do
				opts.capabilities = capabilities

				vim.lsp.config(name, opts)

				vim.lsp.enable(name)
			end
		end,
	},
}

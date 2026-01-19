return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		opts = {
			servers = {
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
						"--query-driver=/usr/bin/g++,/usr/bin/gcc,g++,gcc",
					},
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
				},
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
						},
					},
				},
				nil_ls = {},
				bashls = {},
				yamlls = {},
				marksman = {},
				vimls = {},
			},
		},
		config = function(_, opts)
			require("mason").setup()
			local mason_lsp = require("mason-lspconfig")
			local ensure_installed = vim.tbl_keys(opts.servers)

			mason_lsp.setup({
				ensure_installed = ensure_installed,
				automatic_installation = true,

				handlers = {
					function(server_name)
						local server_opts = opts.servers[server_name] or {}
						server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)

						require("lspconfig")[server_name].setup(server_opts)
					end,
				},
			})
		end,
	},
}

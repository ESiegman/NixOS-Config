return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
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
						"--query-driver=" .. (vim.env.CPLUS_INCLUDE_PATH or ""):gsub(":", ","),
					},
					capabilities = {
						offsetEncoding = { "utf-16" },
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
						},
					},
				},
				bashls = {},
				yamlls = {},
				marksman = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			for server_name, server_opts in pairs(opts.servers) do
				local binary = server_name
				if server_name == "nil_ls" then
					binary = "nil"
				end
				if server_name == "ts_ls" then
					binary = "typescript-language-server"
				end
				if server_name == "lua_ls" then
					binary = "lua-language-server"
				end

				if vim.fn.executable(binary) == 1 then
					server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(server_opts.capabilities)
					lspconfig[server_name].setup(server_opts)
				end
			end
		end,
	},
}

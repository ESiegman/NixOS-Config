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
						Lua = { diagnostics = { globals = { "vim" } } },
					},
				},
				bashls = {},
				yamlls = {},
				marksman = {},
			}

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			for server_name, config in pairs(servers) do
				local default_config = require("lspconfig.configs." .. server_name).default_config

				local final_config = vim.tbl_deep_extend("force", default_config, config, {
					capabilities = capabilities,
				})

				vim.lsp.config(server_name, final_config)

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
					vim.lsp.enable(server_name)
				end
			end
		end,
	},
}

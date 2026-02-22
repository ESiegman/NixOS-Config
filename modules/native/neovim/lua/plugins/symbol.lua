-- lua/plugins/symbol.lua
return {
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		opts = {
			vt_position = "above",
			text_format = function(symbol)
				local fragments = {}

				if symbol.references then
					local num = symbol.references
					local label = num == 1 and "usage" or "usages"
					table.insert(fragments, { "", "SymbolUsageRounding" })
					table.insert(fragments, { string.format("󰌹 %d %s", num, label), "SymbolUsageContent" })
					table.insert(fragments, { "", "SymbolUsageRounding" })
				end

				if symbol.definition then
					if #fragments > 0 then
						table.insert(fragments, { " ", "NonText" })
					end
					table.insert(fragments, { "", "SymbolUsageRounding" })
					table.insert(fragments, { "󰳗 def", "SymbolUsageContent" })
					table.insert(fragments, { "", "SymbolUsageRounding" })
				end

				return fragments
			end,
		},
		config = function(_, opts)
			local colors = require("tokyonight.colors").setup()

			vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = colors.bg_highlight, italic = false })
			vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = colors.bg_highlight, fg = colors.blue, italic = false })

			require("symbol-usage").setup(opts)
		end,
	},
}

local function make_cpp_template(func_info)
	local ls = require("luasnip")
	local fmt = require("luasnip.extras.fmt").fmt
	local i = ls.insert_node
	local t = ls.text_node
	local rep = require("luasnip.extras").rep

	local param_nodes = {}
	local p_index = 3
	for _, param in ipairs(func_info.params) do
		local mirrored_param_node = i(p_index, param.name)
		table.insert(param_nodes, fmt(" * @param {} {}", { mirrored_param_node, i(p_index + 1, "description") }))
		p_index = p_index + 2
	end

	local body = {
		t("/**"),
		fmt(" * @brief {} for {}", { i(1, "brief description"), t(func_info.name or "functionName") }),
		t({ " *" }),
		t(table.concat(param_nodes, "\n")),
		fmt(" * @return {}", { i(2, "return value") }),
		t(" */"),
		i(0),
	}

	return ls.snippet(nil, body)
end

return {
	{
		"danymat/neogen",
		cmd = "Neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {
			snippet_engine = "luasnip",
			template_manager = {
				cpp = {
					template = make_cpp_template,
					annotation_convention = "doxygen",
				},
				c = {
					template = make_cpp_template,
					annotation_convention = "doxygen",
				},
			},
		},
		keys = {
			{ "<leader>g", "<cmd>Neogen<cr>", desc = "Neogen: Generate Docstring" },
		},
	},
}

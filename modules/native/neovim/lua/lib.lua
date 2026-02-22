-- lua/lib.lua
local M = {}

function M.setup(config)
	if config.g then
		for key, value in pairs(config.g) do
			vim.g[key] = value
		end
	end

	if config.opt then
		for key, value in pairs(config.opt) do
			vim.opt[key] = value
		end
	end

	if config.maps then
		for _, map in ipairs(config.maps) do
			local mode, lhs, rhs, opts = map[1], map[2], map[3], map[4] or {}
			local default_opts = { noremap = true, silent = true }
			local final_opts = vim.tbl_extend("force", default_opts, opts)

			vim.keymap.set(mode, lhs, rhs, final_opts)
		end
	end

	if config.autocmds then
		local created_groups = {}

		for _, au in ipairs(config.autocmds) do
			local group_id = nil
			if au.group then
				if not created_groups[au.group] then
					created_groups[au.group] = vim.api.nvim_create_augroup(au.group, { clear = true })
				end
				group_id = created_groups[au.group]
			end

			vim.api.nvim_create_autocmd(au.event, {
				group = group_id,
				pattern = au.pattern or "*",
				callback = au.callback,
				command = au.command,
				desc = au.desc,
			})
		end
	end

	if config.commands then
		for _, cmd in ipairs(config.commands) do
			vim.api.nvim_create_user_command(cmd.name, cmd.command, cmd.opts or {})
		end
	end
end

return M

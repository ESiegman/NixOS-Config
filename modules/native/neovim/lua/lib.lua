local M = {}

function M.setup(config)
    -- 1. Options
    if config.opt then
        for key, value in pairs(config.opt) do
            vim.opt[key] = value
        end
    end

    -- 2. Globals
    if config.g then
        for key, value in pairs(config.g) do
            vim.g[key] = value
        end
    end

    -- 3.Keymaps
    if config.maps then
        for _, map in ipairs(config.maps) do
            vim.keymap.set(map[1], map[2], map[3], map[4])
        end
    end

    -- 4. Autocommands
    if config.autocmds then
        for _, au in ipairs(config.autocmds) do
            local group_id = nil
            if au.group then
                group_id = vim.api.nvim_create_augroup(au.group, { clear = true })
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

    -- 5. User Commands
    if config.commands then
        for _, cmd in ipairs(config.commands) do
            vim.api.nvim_create_user_command(cmd.name, cmd.command, cmd.opts or {})
        end
    end
end

return M

local oil_actions = require("oil.actions")

local M = {}

M.setup = function()
    require("oil").setup({
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        use_default_keymaps = false,
        view_options = {
            show_hidden = false,
            -- use wildignore as ignore rule
            is_hidden_file = function(name, bufnr)
                local patterns = vim.split(vim.o.wildignore, ",")
                table.insert(patterns, "..")
                for _, pattern in ipairs(patterns) do
                    -- convert to lua regex
                    pattern = pattern:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1"):gsub("%*", ".*"):gsub("%?", ".")
                    if string.match(name, "^" .. pattern .. "$") then
                        return true
                    end
                end
                return false
            end,
        },
    })
end

M.open_trash = function()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_name(buf) == "oil-trash:///" then
            vim.api.nvim_set_current_win(win)
            return
        end
    end
    vim.cmd(":vs")
    oil_actions.toggle_trash.callback()
end

local parse_url = function(url)
    return url:match("^.*://(.*)$")
end

M.actions_post_callback = function(args)
    if args.data.err then
        return
    end

    local dels = {}
    for _, action in ipairs(args.data.actions) do
        if action.type == "delete" then
            local path = parse_url(action.url)
            if action.entry_type == "file" then
                local bufnr = vim.fn.bufnr(path)
                if vim.api.nvim_buf_is_loaded(bufnr) then
                    table.insert(dels, {
                        bufnr = bufnr,
                        name = path,
                    })
                end
            elseif action.entry_type == "directory" then
                local all_bufs = vim.api.nvim_list_bufs()
                for _, bufnr in ipairs(all_bufs) do
                    if vim.api.nvim_buf_is_loaded(bufnr) then
                        local bufname = vim.fn.bufname(bufnr)
                        if bufname:find(path, 1, true) == 1 then
                            table.insert(dels, {
                                bufnr = bufnr,
                                name = bufname,
                            })
                        end
                    end
                end
            end
        end
    end

    for _, b in ipairs(dels) do
        vim.notify("buf " .. b.bufnr .. " for file " .. b.name .. " was deleted")
        vim.cmd("bd! " .. b.bufnr)
    end
end

return M

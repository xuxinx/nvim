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

return M

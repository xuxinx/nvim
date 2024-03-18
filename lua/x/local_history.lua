local M = {}

M.init = function()
    vim.g.local_history_new_change_delay = 60
    vim.g.local_history_exclude = {
        "oil://**",
        "oil-trash://**",
    }
end

return M

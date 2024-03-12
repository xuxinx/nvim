local M = {}

M.setup = function()
    vim.g.local_history_new_change_delay = 60
    vim.g.local_history_exclude = {
        "oil://**",
        "oil-trash://**",
    }
end

return M

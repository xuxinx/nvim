local M = {}

M.open_terminal_for_current_dir = function ()
    vim.cmd("belowright split term://%:p:h//zsh")
end

return M

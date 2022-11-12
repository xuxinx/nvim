local M = {}

function M.restore_cursor()
    local exit_line = vim.fn.line('\'"')
    if exit_line >= 1 and exit_line <= vim.fn.line('$') then
        vim.cmd [[normal! g`"]]
    end
end

return M

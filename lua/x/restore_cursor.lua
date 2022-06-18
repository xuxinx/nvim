local M = {}

function M.restoreCursor()
    local exitLine = vim.fn.line('\'"')
    if exitLine >= 1 and exitLine <= vim.fn.line('$') then
        vim.cmd [[normal! g`"]]
    end
end

return M

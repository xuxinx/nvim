local M = {}

function M.currDir()
    return vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
end

function M.baseCwd()
    return vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
end

function M.currFilePath()
    return vim.fn.expand('%:p:~:.')
end

return M

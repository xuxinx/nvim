local M = {}

M.toggle = function()
    for _, info in pairs(vim.fn.getwininfo()) do
        if info.quickfix == 1 then
            vim.cmd("cclose")
            return
        end
    end
    vim.cmd("copen")
end

M.next = function()
    local qflist = vim.fn.getqflist()
    local idx = vim.fn.getqflist({ idx = 0 }).idx
    if idx < #qflist then
        vim.cmd('cnext')
    else
        vim.cmd('cfirst')
    end
end

M.prev = function()
    local idx = vim.fn.getqflist({ idx = 0 }).idx
    if idx > 1 then
        vim.cmd('cprev')
    else
        vim.cmd('clast')
    end
end

return M

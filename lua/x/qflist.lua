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

return M

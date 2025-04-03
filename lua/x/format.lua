local M = {}

M.format = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
    end
    if vim.bo[bufnr].filetype == "go" then
        require("x.go").goimports(1000)
        return
    end
    -- FIXME: Formatter 'goimports' timeout
    require("conform").format({
        bufnr = bufnr,
        timeout_ms = 1000,
    })
end

M.disable_global = function()
    vim.g.disable_autoformat = true
end

M.disable_buffer = function()
    vim.b.disable_autoformat = true
end

M.enable = function()
    vim.g.disable_autoformat = false
    vim.b.disable_autoformat = false
end

return M

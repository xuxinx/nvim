local utils = require("x.utils")

local M = {}

local prettier_files = utils.list_to_set({ "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "css", "less", "scss", "html", "json", "graphql", "markdown", "yaml" })

M.format = function()
    local ft = vim.bo.filetype
    if prettier_files[ft] then
        vim.cmd("Prettier")
    elseif ft == "python" then
        vim.cmd("w")
        vim.cmd("silent !black %")
    else
        vim.lsp.buf.format()
    end
end

return M

local xutils = require("x.utils")

local M = {}

local prettier_files = xutils.list_to_set({ "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "css", "less", "scss", "html", "json", "graphql", "markdown", "yaml" })

M.format = function ()
    if prettier_files[vim.bo.filetype] then
        vim.cmd("Prettier")
    else
        vim.lsp.buf.format()
    end
end

return M

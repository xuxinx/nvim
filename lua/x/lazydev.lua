local M = {}

M.setup = function()
    require("lazydev").setup({
        library = {
            "luvit-meta/library",
        },
    })
end

return M

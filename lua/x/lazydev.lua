local ld = require("lazydev")

local M = {}

M.setup = function()
    ld.setup({
        library = {
            "luvit-meta/library",
        },
    })
end

return M

local g = require("gitsigns")

local M = {}

M.setup = function()
    g.setup({
        signs = {
            add          = { text = '+' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        attach_to_untracked = true,
    })
end

return M

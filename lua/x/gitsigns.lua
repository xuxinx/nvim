local M = {}

M.setup = function()
    require("gitsigns").setup({
        signs = {
            add = { text = '+' },
            change = { text = '│' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        attach_to_untracked = true,
    })
end

return M

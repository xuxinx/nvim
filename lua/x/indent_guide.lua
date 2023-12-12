local ibl = require('ibl')

local M = {}

M.setup = function()
    vim.api.nvim_set_hl(0, 'IndentGuide', { fg = '#f5f5f5', bold = false })
    ibl.setup {
        indent = {
            char = "|",
            highlight = {
                'IndentGuide',
            }
        },
        scope = {
            enabled = false,
        },
    }
end

return M

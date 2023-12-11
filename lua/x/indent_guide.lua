local ibl = require('ibl')

local M = {}

M.setup = function()
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

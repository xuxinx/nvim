local ibl = require("ibl")

local M = {}

M.setup = function()
    ibl.setup {
        indent = {
            char = "|",
        },
        scope = {
            enabled = false,
        },
    }
end

return M

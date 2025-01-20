local M = {}

M.setup = function()
    local ibl = require("ibl")

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

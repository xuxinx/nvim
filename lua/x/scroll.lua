local neoscroll = require("neoscroll")

local M = {}

M.setup = function()
    neoscroll.setup {
        cursor_scrolls_alone = false,
    }
end

return M

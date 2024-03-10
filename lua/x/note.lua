local telescopebi = require("telescope.builtin")
local xtelescope = require("x.telescope")

local M = {}

local dir = "$HOME/xhome/notes"

M.find_note = function()
    xtelescope.find_files({
        cwd = dir,
    })
end

M.grep_note = function()
    telescopebi.live_grep({
        cwd = dir,
    })
end

return M

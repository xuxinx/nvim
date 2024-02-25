local telescope = require("telescope.builtin")

local M = {}

local dir = "$HOME/xhome/notes"

M.find_note = function()
    telescope.find_files({
        cwd = dir,
        hidden = true,
        no_ignore = true,
    })
end

M.grep_note = function()
    telescope.live_grep({
        cwd = dir,
    })
end

return M

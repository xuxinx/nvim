local M = {}

local dir = "$HOME/xhome/notes"

M.find_note = function()
    require("x.telescope").find_files({
        cwd = dir,
    })
end

M.grep_note = function()
    require("telescope.builtin").live_grep({
        cwd = dir,
    })
end

return M

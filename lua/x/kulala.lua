local telescopebi = require("telescope.builtin")
local xtelescope = require("x.telescope")

local M = {}

local rest_src = "$HOME/xhome/rest"

M.setup = function()
    require("kulala").setup({
        default_view = "headers_body",
    })
end

M.find_rest = function()
    xtelescope.find_files({
        cwd = rest_src,
    })
end

M.grep_rest = function()
    telescopebi.live_grep({
        cwd = rest_src,
    })
end

return M

local util = require("x.utils")

local M = {}

M.open_terminal_for_current_dir = function()
    local path = "%:p:h/"
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name:find("oil://", 1, true) then
        path = util.trim_prefix(buf_name, "oil://")
    end
    vim.cmd("belowright split term://" .. path .. "/zsh")
    vim.api.nvim_input("a")
end

M.open_terminal_for_root_dir = function()
    local path = vim.fn.getcwd() .. "/"
    vim.cmd("belowright split term://" .. path .. "/zsh")
    vim.api.nvim_input("a")
end

return M

local utils = require("x.utils")

local M = {}

M.copy_file_pos = function()
    local path = utils.get_curr_file_relative_path()
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local pos = path .. ":" .. line .. ":" .. col
    vim.fn.setreg("+", pos)
    vim.notify(pos)
end

M.copy_file_abs_pos = function()
    local path = utils.get_curr_file_absolute_path()
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local pos = path .. ":" .. line .. ":" .. col
    vim.fn.setreg("+", pos)
    vim.notify(pos)
end

return M

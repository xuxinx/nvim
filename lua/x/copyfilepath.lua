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

local function visual_range()
    local s = vim.fn.getpos("v")
    local e = vim.fn.getpos(".")
    if s[2] > e[2] or (s[2] == e[2] and s[3] > e[3]) then
        s, e = e, s
    end
    return s[2], s[3], e[2], e[3]
end

M.copy_file_pos_visual = function()
    local path = utils.get_curr_file_relative_path()
    local sl, sc, el, ec = visual_range()
    local pos = path .. ":" .. sl .. ":" .. sc .. "-" .. el .. ":" .. ec
    vim.fn.setreg("+", pos)
    vim.notify(pos)
end

M.copy_file_abs_pos_visual = function()
    local path = utils.get_curr_file_absolute_path()
    local sl, sc, el, ec = visual_range()
    local pos = path .. ":" .. sl .. ":" .. sc .. "-" .. el .. ":" .. ec
    vim.fn.setreg("+", pos)
    vim.notify(pos)
end

return M

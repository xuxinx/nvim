local utils = require("x.utils")

local M = {}

local function oil_entry_path(absolute)
    local oil = package.loaded["oil"]
    if not oil then return nil end
    if vim.bo.filetype ~= "oil" then return nil end
    local entry = oil.get_cursor_entry()
    if not entry then return nil end
    local dir = oil.get_current_dir()
    if not dir then return nil end
    local full = dir .. entry.name
    if absolute then return full end
    return vim.fn.fnamemodify(full, ":~:.")
end

M.copy_file_pos = function()
    local oil_path = oil_entry_path(false)
    if oil_path then
        vim.fn.setreg("+", oil_path)
        vim.notify(oil_path)
        return
    end
    local path = utils.get_curr_file_relative_path()
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local pos = path .. ":" .. line .. ":" .. col
    vim.fn.setreg("+", pos)
    vim.notify(pos)
end

M.copy_file_abs_pos = function()
    local oil_path = oil_entry_path(true)
    if oil_path then
        vim.fn.setreg("+", oil_path)
        vim.notify(oil_path)
        return
    end
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

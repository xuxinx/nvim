local utils = require("x.utils")

local M = {}

local replace_word = function(new)
    vim.cmd("execute 'normal diw'")
    vim.api.nvim_put({ new }, "c", false, false)
end

M.to_lower_camel = function()
    local old = vim.fn.expand("<cword>")
    if not string.find(old, "_") then
        return
    end
    local new = utils.lower_camel_string(old)
    replace_word(new)
end

M.to_camel = function()
    local old = vim.fn.expand("<cword>")
    if not string.find(old, "_") then
        return
    end
    local new = utils.camel_string(old)
    replace_word(new)
end

M.to_snake = function()
    local old = vim.fn.expand("<cword>")
    if string.find(old, "_") then
        return
    end
    local new = utils.snake_string(old)
    replace_word(new)
end

return M

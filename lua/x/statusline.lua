local M = {}

local utils = require('x.utils')

function M.currFilePath()
    local path = utils.currFilePath()
    if (path == '') then
        return '[No Name]'
    end
    return path
end

function M.statusline()
    local s = ''

    -- base cwd
    s = s .. utils.baseCwd() .. ':'

    -- filepath
    s = s .. [[ %{v:lua.require'x.statusline'.currFilePath()}]]

    -- modified readonly help preview
    s = s .. '%m%r%h%w'

    -- git status
    s = s .. [[ %{get(b:,'gitsigns_status','')}]]

    -- spacer
    s = s .. '%='

    -- row col
    s = s .. '%l/%L,%c'

    -- file format
    s = s .. ' | %{&fileformat}'

    -- file encoding
    s = s .. [[ | %{&fileencoding ? &fileencoding : &encoding}]]

    -- filetype
    if vim.bo.filetype ~= '' then
        s = s .. [[ | %{&filetype}]]
    end

    -- git branch
    s = s .. [[ | %{get(b:,'gitsigns_head','')}]]

    return s
end

return M

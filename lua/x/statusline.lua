local utils = require('x.utils')

local M = {}
M.helpers = {}

function M.helpers.currFilePath()
    local path = utils.currFilePath()
    if (path == '') then
        return '[No Name]'
    end
    return path
end

local lspDiagnosticInfo = {}

local function updateLspDiagnosticInfo()
    local errorCount = 0
    local warnCount = 0
    local infoCount = 0
    local hintCount = 0
    local info = vim.diagnostic.get(0)
    for _, v in ipairs(info) do
        if v.severity == vim.diagnostic.severity.ERROR then
            errorCount = errorCount + 1
        elseif v.severity == vim.diagnostic.severity.WARN then
            warnCount = warnCount + 1
        elseif v.severity == vim.diagnostic.severity.INFO then
            infoCount = infoCount + 1
        elseif v.severity == vim.diagnostic.severity.HINT then
            hintCount = hintCount + 1
        else
            print('unknown diagnostic severity: ' .. v.severity)
        end
    end

    local s = ''
    if errorCount > 0 then
        s = s .. 'E' .. errorCount
    end
    if warnCount > 0 then
        s = s .. 'W' .. warnCount
    end
    if infoCount > 0 then
        s = s .. 'I' .. infoCount
    end
    if hintCount > 0 then
        s = s .. 'H' .. hintCount
    end

    lspDiagnosticInfo[vim.api.nvim_buf_get_name(0)] = s
end

vim.api.nvim_create_autocmd({'BufEnter', 'DiagnosticChanged'}, {
    pattern = {'*'},
    callback = updateLspDiagnosticInfo,
})

function M.helpers.getLspDiagnosticInfo()
    local v = lspDiagnosticInfo[vim.api.nvim_buf_get_name(0)]
    if v == nil then
        return ''
    end
    return v
end

function M.statusline()
    local s = ''

    -- base cwd
    s = s .. utils.baseCwd() .. ':'

    -- filepath
    s = s .. [[ %{v:lua.require'x.statusline'.helpers.currFilePath()}]]

    -- modified readonly help preview
    s = s .. '%m%r%h%w'

    -- git status
    s = s .. [[ %{get(b:,'gitsigns_status','')}]]

    -- lsp diagnostics
    s = s .. [[ %{v:lua.require'x.statusline'.helpers.getLspDiagnosticInfo()}]]

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

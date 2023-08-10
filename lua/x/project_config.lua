local M = {}

PCFG = {}
local PCFG_default = {
    telescope = {
        ignore_dirs = {},
        ignore_file_extensions = {},
        ignore_files = {},
        ignore_free_patterns = {},
    }
}

local store_dir = vim.fn.stdpath('data') .. '/project_configs/'
vim.fn.mkdir(store_dir, 'p')

local function fname()
    return string.gsub(vim.fn.getcwd() .. '.lua', '/', '%%')
end

M.edit = function()
    local f = store_dir .. fname()
    if vim.fn.filereadable(f) ~= 1 then
        local wf = assert(io.open(f, 'w'))
        wf:write([[
PCFG = {
    telescope = {
        ignore_dirs = {},
        ignore_file_extensions = {},
        ignore_files = {},
        ignore_free_patterns = {},
    }
}
        ]])
        wf:close()
    end
    vim.cmd('e ' .. vim.fn.fnameescape(f))
end

M.load = function()
    local f = store_dir .. fname()
    if vim.fn.filereadable(f) == 1 then
        vim.cmd('luafile ' .. vim.fn.fnameescape(f))
    end
    PCFG = vim.tbl_deep_extend('force', PCFG_default, PCFG)
end

return M

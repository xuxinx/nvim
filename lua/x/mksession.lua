local utils = require('x.utils')

local M = {}

local store_dir = vim.fn.stdpath('data') .. '/sessions/'
vim.fn.mkdir(store_dir, 'p')

local function fname(sname)
    if sname == nil or sname == '' then
        sname = 'auto_session'
    end
    return string.gsub(vim.fn.getcwd() .. '/' .. sname, '/', '%%')
end

M.save_session = function(sname)
    vim.cmd('mksession! ' .. vim.fn.fnameescape(store_dir .. fname(sname)))
end

M.load_session = function(sname)
    if vim.fn.filereadable(store_dir .. fname(sname)) ~= 1 then
        print('session not found')
        return
    end
    vim.cmd('source ' .. vim.fn.fnameescape(store_dir .. fname(sname)))
end

M.select_session = function()
    local sessions = {}
    local all_sessions = vim.split(vim.fn.glob(store_dir .. "*"), '\n')
    local prefix = store_dir .. string.gsub(vim.fn.getcwd() .. '/', '/', '%%')
    for _, s in ipairs(all_sessions) do
        local name = utils.trim_prefix(s, prefix)
        if (not string.find(name, '%%')) and (not string.find(name, '/')) then
            table.insert(sessions, name)
        end
    end
    if next(sessions) == nil then
        print('no sessions')
        return
    end
    vim.ui.select(sessions, {
        prompt = 'select a session',
    }, function(selected, _)
        if not selected then
            return
        end
        M.load_session(selected)
    end)
end

return M

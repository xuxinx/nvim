local utils = require('x.utils')

local M = {}

local store_dir = vim.fn.stdpath('data') .. '/sessions/'
local auto_session_name = 'auto_session'

vim.fn.mkdir(store_dir, 'p')

local function fname(sname)
    if sname == nil or sname == '' then
        sname = auto_session_name
    end
    return string.gsub(vim.fn.getcwd() .. '/' .. sname, '/', '%%')
end

local function cwd_sessions()
    local sessions = {}
    local all_sessions = vim.split(vim.fn.glob(store_dir .. "*"), '\n')
    local prefix = store_dir .. string.gsub(vim.fn.getcwd() .. '/', '/', '%%')
    for _, s in ipairs(all_sessions) do
        local name = utils.trim_prefix(s, prefix)
        if (not string.find(name, '%%')) and (not string.find(name, '/')) then
            if (name == auto_session_name) then
                table.insert(sessions, 1, name)
            else
                table.insert(sessions, name)
            end
        end
    end
    return sessions
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

M.delete_session = function(sname)
    if vim.fn.filereadable(store_dir .. fname(sname)) ~= 1 then
        print('session not found')
        return
    end
    os.remove(store_dir .. fname(sname))
end

M.select_session_to_load = function()
    local sessions = cwd_sessions()
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

M.select_session_to_delete = function()
    local sessions = cwd_sessions()
    if next(sessions) == nil then
        print('no sessions')
        return
    end
    vim.ui.select(sessions, {
        prompt = 'select a session to delete',
    }, function(selected, _)
        if not selected then
            return
        end
        M.delete_session(selected)
    end)
end

return M

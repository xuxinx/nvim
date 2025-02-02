local utils = require("x.utils")

local M = {}

local store_dir = utils.join_path(vim.fn.stdpath("data"), "sessions") .. "/"
local breakpoints_dir = utils.join_path(store_dir, "breakpoints") .. "/"
local auto_session_name = "auto_session"
M.auto_session_name = auto_session_name

vim.fn.mkdir(store_dir, "p")
vim.fn.mkdir(breakpoints_dir, "p")

local function fname(sname)
    if sname == nil or sname == "" then
        sname = auto_session_name
    end
    return string.gsub(vim.fn.getcwd() .. "/" .. sname, "/", "%%")
end

local function cwd_sessions()
    local sessions = {}
    local all_sessions = vim.split(vim.fn.glob(store_dir .. "*"), "\n")
    local prefix = store_dir .. string.gsub(vim.fn.getcwd() .. "/", "/", "%%")
    for _, s in ipairs(all_sessions) do
        local name = utils.trim_prefix(s, prefix)
        if (not string.find(name, "%%")) and (not string.find(name, "/")) then
            if (name == auto_session_name) then
                table.insert(sessions, 1, name)
            else
                table.insert(sessions, name)
            end
        end
    end
    return sessions
end

-- https://github.com/mfussenegger/nvim-dap/issues/198
local function save_breakpoints(sname)
    local breakpoints = require("dap.breakpoints")

    local bps = {}
    local breakpoints_by_buf = breakpoints.get()
    if next(breakpoints_by_buf) == nil then
        os.remove(breakpoints_dir .. fname(sname))
        return
    end
    for buf, buf_bps in pairs(breakpoints_by_buf) do
        bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
    end
    local fpath = breakpoints_dir .. fname(sname)
    local fp = assert(io.open(fpath, "w"))
    fp:write(vim.fn.json_encode(bps))
    fp:close()
end

local function load_breakpoints(sname)
    local breakpoints = require("dap.breakpoints")

    breakpoints.clear()
    local fpath = breakpoints_dir .. fname(sname)
    if vim.fn.filereadable(fpath) ~= 1 then
        return
    end
    local fp = assert(io.open(fpath, "r"))
    local content = fp:read("*a")
    fp:close()
    local bps = vim.fn.json_decode(content)
    local loaded_bufs = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        loaded_bufs[vim.api.nvim_buf_get_name(buf)] = buf
    end
    for buf_name, buf_bps in pairs(bps) do
        local buf = loaded_bufs[buf_name]
        if buf ~= nil then
            for _, bp in pairs(buf_bps) do
                local line = bp.line
                local opts = {
                    condition = bp.condition,
                    log_message = bp.logMessage,
                    hit_condition = bp.hitCondition
                }
                breakpoints.set(opts, buf, line)
            end
        end
    end
end

local function clean_buffers()
    local clean_fts = {
        "copilot-chat",
    }
    local clean_names = {
        "kulala://ui",
    }
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        local ft = vim.api.nvim_get_option_value("filetype", {
            buf = bufnr,
        })
        local name = vim.api.nvim_buf_get_name(bufnr)
        if vim.tbl_contains(clean_fts, ft) or
            vim.tbl_contains(clean_names, name) then
            vim.api.nvim_buf_delete(bufnr, { force = true })
        end
    end
end

M.save_session = function(sname)
    clean_buffers()
    vim.cmd("mksession! " .. vim.fn.fnameescape(store_dir .. fname(sname)))
    save_breakpoints(sname)
end

M.load_session = function(sname)
    if vim.fn.filereadable(store_dir .. fname(sname)) ~= 1 then
        vim.notify("session not found", vim.log.levels.ERROR)
        return
    end
    vim.cmd("source " .. vim.fn.fnameescape(store_dir .. fname(sname)))
    load_breakpoints(sname)
end

M.delete_session = function(sname)
    if vim.fn.filereadable(store_dir .. fname(sname)) ~= 1 then
        vim.notify("session not found", vim.log.levels.ERROR)
        return
    end
    os.remove(store_dir .. fname(sname))
    os.remove(breakpoints_dir .. fname(sname))
end

M.select_session_to_load = function()
    local sessions = cwd_sessions()
    if next(sessions) == nil then
        vim.notify("no sessions")
        return
    end
    if #sessions == 1 then
        M.load_session(sessions[1])
        return
    end
    vim.ui.select(sessions, {
        prompt = "select a session",
    }, function(selected, _)
        if not selected then
            selected = sessions[1]
        end
        M.load_session(selected)
    end)
end

M.select_session_to_delete = function()
    local sessions = cwd_sessions()
    if next(sessions) == nil then
        vim.notify("no sessions")
        return
    end
    vim.ui.select(sessions, {
        prompt = "select a session to delete",
    }, function(selected, _)
        if not selected then
            return
        end
        M.delete_session(selected)
    end)
end

return M

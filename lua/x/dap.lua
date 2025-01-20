local M = {}

local repl_win_opts = {
    height = 15,
}

local sidebar_win_opts = {
    width = 50,
}

local scopes
local init_scopes = function()
    local widgets = require("dap.ui.widgets")

    scopes = widgets.sidebar(widgets.scopes, sidebar_win_opts)
end

M.toggle_repl = function()
    require("dap.repl").toggle(repl_win_opts)
end

M.toggle_scopes = function()
    scopes.toggle()
end

local setup_go = function()
    local dap = require("dap")
    local repl = require("dap.repl")
    local utils = require("dap.utils")

    dap.adapters.go = function(callback, _)
        local stdout = vim.uv.new_pipe(false)
        local stderr = vim.uv.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
            stdio = { nil, stdout, stderr },
            args = { "dap", "-l", "127.0.0.1:" .. port },
            detached = true
        }
        handle, pid_or_err = vim.uv.spawn("dlv", opts, function(code)
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
                vim.notify("dlv exited with code " .. code, vim.log.levels.WARN)
            end
        end)
        assert(handle, "Error running dlv: " .. tostring(pid_or_err))
        stdout:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    repl.append(chunk)
                end)
            end
        end)
        stderr:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    repl.append(chunk)
                end)
            end
        end)
        -- Wait for delve to start
        vim.defer_fn(
            function()
                callback({ type = "server", host = "127.0.0.1", port = port })
            end,
            100)
    end
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
        {
            type = "go",
            name = "Debug",
            request = "launch",
            program = "${fileDirname}"
        },
        {
            type = "go",
            name = "Attach",
            mode = "local",
            request = "attach",
            processId = utils.pick_process,
        },
        -- {
        --     type = "go",
        --     name = "Debug test",
        --     request = "launch",
        --     mode = "test",
        --     program = "${fileDirname}"
        -- }
    }
end

M.setup = function()
    local dap = require("dap")

    init_scopes()

    dap.listeners.after.event_initialized["ui_config"] = function()
        dap.repl.open(repl_win_opts)
        scopes.open()
    end

    dap.listeners.before.event_terminated["ui_config"] = function()
        dap.repl.close()
        scopes.close()
    end

    dap.listeners.before.event_exited["ui_config"] = function()
        dap.repl.close()
        scopes.close()
    end

    setup_go()
end

M.debug_test = function()
    local dap = require("dap")

    local ft = vim.bo.filetype
    if ft == "go" then
        local fname = require("x.treesitter").get_func_name({
            function_declaration = true,
        })
        if fname == nil then
            return
        end
        dap.run({
            type = "go",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${fileDirname}",
            args = function()
                return { "-test.run", fname }
            end,
        })
    else
        vim.notify(ft .. " is not support in debug_test", vim.log.levels.ERROR)
    end
end

return M

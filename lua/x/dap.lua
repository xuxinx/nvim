local dap = require("dap")
local widgets = require("dap.ui.widgets")
local repl = require("dap.repl")
local utils = require("dap.utils")

local M = {}

local scopes = widgets.sidebar(widgets.scopes, { width = 50 })

M.toggle_scopes = function ()
    scopes.toggle()
end

local setup_go = function()
    dap.adapters.go = function(callback, config)
        local stdout = vim.loop.new_pipe(false)
        local stderr = vim.loop.new_pipe(false)
        local handle
        local pid_or_err
        local port = 38697
        local opts = {
            stdio = { nil, stdout, stderr },
            args = { "dap", "-l", "127.0.0.1:" .. port },
            detached = true
        }
        handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
                print("dlv exited with code", code)
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
    dap.listeners.after.event_initialized["ui_config"] = function()
        dap.repl.open({ height = 20 })
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
    dap.run({
        type = "go",
        name = "Debug test",
        request = "launch",
        mode = "test",
        program = "${fileDirname}",
        args = function()
            local input = vim.fn.input("Test name: ")
            return { "-test.run", input }
        end,
    })
end

return M

local dap = require("dap")
local widgets = require("dap.ui.widgets")

local M = {}

local scopes = widgets.sidebar(widgets.scopes, { width = 50 })

M.scopes = scopes

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

    require("x.dap_go").setup()
end

return M

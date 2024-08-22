local xoil = require("x.oil")
local oil = require("oil")
local oil_actions = require("oil.actions")

local cs = {
    { "Note", require("x.note").find_note, { desc = "find note" } },
    { "NoteG", require("x.note").grep_note, { desc = "grep note" } },
    { "Z", function(o) require("x.z").z_navi("lcd", o.args) end, { nargs = 1, desc = "z local jump" } },
    { "Zg", function(o) require("x.z").z_navi("cd", o.args) end, { nargs = 1, desc = "z global jump" } },
    { "OpenGit", require("x.open").open_git, { desc = "open git" } },
    { "OpenFinder", require("x.open").open_finder, { desc = "open finder" } },
    { "ClearBreakpoints", require("dap").clear_breakpoints, { desc = "clear breakpoints" } },
    { "DebugScopes", require("x.dap").toggle_scopes, { desc = "toggle debug scopes" } },
    { "DebugRepl", require("x.dap").toggle_repl, { desc = "toggle debug repl" } },
    { "SaveSession", function(o) require("x.session").save_session(o.args) end, { nargs = "?", desc = "save session" } },
    { "LoadSession", require("x.session").select_session_to_load, { desc = "select a session to load" } },
    { "DelSession", require("x.session").select_session_to_delete, { desc = "select a session to delete" } },
    { "ProjectConfig", require("x.project_config").edit, { desc = "edit project config" } },
    {
        event = "FileType",
        pattern = "oil",
        { "OilRefresh", oil_actions.refresh.callback, { desc = "refresh list" } },
        { "OilTrash", xoil.open_trash, { desc = "open trash" } },
        { "OilHidden", oil_actions.toggle_hidden.callback, { desc = "toggle hidden" } },
        { "OilCmd", oil_actions.open_cmdline.callback, { desc = "open cmdline" } },
        { "OilCmdDir", oil_actions.open_cmdline_dir.callback, { desc = "open cmdline" } },
        { "OilDiscardChanges", oil.discard_all_changes, { desc = "discard all changes" } },
    },
    { "CopyPath", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "copy full path of current buffer to clipboard" } },
}

local group = vim.api.nvim_create_augroup("x_augroup_usercommands", { clear = true })
for _, c in ipairs(cs) do
    if c.event ~= nil then
        vim.api.nvim_create_autocmd(c.event, {
            group = group,
            pattern = c.pattern,
            callback = function()
                for _, ec in ipairs(c) do
                    vim.api.nvim_buf_create_user_command(0, ec[1], ec[2], ec[3])
                end
            end
        })
    else
        vim.api.nvim_create_user_command(c[1], c[2], c[3])
    end
end

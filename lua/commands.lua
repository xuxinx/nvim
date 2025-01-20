local cs = {
    { "Note", function() require("x.note").find_note() end, { desc = "find note" } },
    { "NoteG", function() require("x.note").grep_note() end, { desc = "grep note" } },
    { "Z", function(o) require("x.z").z_navi("lcd", o.args) end, { nargs = 1, desc = "z local jump" } },
    { "Zg", function(o) require("x.z").z_navi("cd", o.args) end, { nargs = 1, desc = "z global jump" } },
    { "OpenGit", function() require("x.open").open_git() end, { desc = "open git" } },
    { "OpenFinder", function() require("x.open").open_finder() end, { desc = "open finder" } },
    { "ClearBreakpoints", function() require("dap").clear_breakpoints() end, { desc = "clear breakpoints" } },
    { "DebugScopes", function() require("x.dap").toggle_scopes() end, { desc = "toggle debug scopes" } },
    { "DebugRepl", function() require("x.dap").toggle_repl() end, { desc = "toggle debug repl" } },
    { "SaveSession", function(o) require("x.session").save_session(o.args) end, { nargs = "?", desc = "save session" } },
    { "LoadSession", function() require("x.session").select_session_to_load() end, { desc = "select a session to load" } },
    { "DelSession", function() require("x.session").select_session_to_delete() end, { desc = "select a session to delete" } },
    { "ProjectConfig", function() require("x.project_config").edit() end, { desc = "edit project config" } },
    {
        event = "FileType",
        pattern = "oil",
        { "OilRefresh", function() require("oil.actions").refresh.callback() end, { desc = "refresh list" } },
        { "OilTrash", function() require("x.oil").open_trash() end, { desc = "open trash" } },
        { "OilHidden", function() require("oil.actions").toggle_hidden.callback() end, { desc = "toggle hidden" } },
        { "OilCmd", function() require("oil.actions").open_cmdline.callback() end, { desc = "open cmdline" } },
        { "OilCmdDir", function() require("oil.actions").open_cmdline_dir.callback() end, { desc = "open cmdline" } },
        { "OilDiscardChanges", function() require("oil").discard_all_changes() end, { desc = "discard all changes" } },
    },
    { "CopyPath", function() vim.fn.setreg("+", vim.fn.expand("%:p")) end, { desc = "copy full path of current buffer to clipboard" } },
    { "Rest", function() require("x.kulala").find_rest() end, { desc = "find rest" } },
    { "RestG", function() require("x.kulala").grep_rest() end, { desc = "grep rest" } },
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

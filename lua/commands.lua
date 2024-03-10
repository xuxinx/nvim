local cc = vim.api.nvim_create_user_command
local bcc = function(name, command, opts)
    vim.api.nvim_buf_create_user_command(0, name, command, opts)
end
local group = vim.api.nvim_create_augroup("x_augroup_usercommands", { clear = true })
local cac = function(event, opts)
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
end

cc("Note", require("x.note").find_note, { desc = "find note" })
cc("NoteG", require("x.note").grep_note, { desc = "grep note" })
cc("Z", function(o) require("x.z").z_navi("lcd", o.args) end, { nargs = 1, desc = "z local jump" })
cc("Zg", function(o) require("x.z").z_navi("cd", o.args) end, { nargs = 1, desc = "z global jump" })
cc("OpenGit", require("x.open_git").open_git, { desc = "open git" })
cc("Rename", function() vim.lsp.buf.rename() end, { desc = "rename var" })
cc("DebugTest", require("x.dap").debug_test, { desc = "debug test" })
cc("DebugScopes", require("x.dap").toggle_scopes, { desc = "toggle debug scopes" })
cc("DebugRepl", function() require("dap").repl.toggle() end, { desc = "toggle debug repl" })
cc("SaveSession", function(o) require("x.session").save_session(o.args) end, { nargs = "?", desc = "save session" })
cc("LoadSession", require("x.session").select_session_to_load, { desc = "select a session to load" })
cc("DelSession", require("x.session").select_session_to_delete, { desc = "select a session to delete" })
cc("ProjectConfig", require("x.project_config").edit, { desc = "edit project config" })
cc("Term", require("x.terminal").open_terminal_for_current_dir, { desc = "open terminal for current dir" })
cac("FileType", {
    pattern = "go",
    callback = function()
        bcc("GoGenerate", require("x.go").execute_go_generate, { desc = "execute go:generate" })
    end
})

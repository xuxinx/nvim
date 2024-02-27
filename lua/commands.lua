local cb = require("x.callbacks.command")

local cc = vim.api.nvim_create_user_command
local bcc = function (name, command, opts)
    vim.api.nvim_buf_create_user_command(0, name, command, opts)
end
local group = vim.api.nvim_create_augroup("x_augroup_usercommands", { clear = true })
local cac = function(event, opts)
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
end

cc("Note", cb.find_note, { desc = "find note" })
cc("NoteG", cb.grep_note, { desc = "grep note" })
cc("Z", cb.z_local_jump, { nargs = 1, desc = "z local jump" })
cc("Zg", cb.z_global_jump, { nargs = 1, desc = "z global jump" })
cc("OpenGit", cb.open_git, { desc = "open git" })
cc("Rename", cb.rename_var, { desc = "rename var" })
cc("DebugTest", cb.debug_test, { desc = "debug test" })
cc("DebugScopes", cb.toggle_debug_scopes, { desc = "toggle debug scopes" })
cc("DebugRepl", cb.toggle_debug_repl, { desc = "toggle debug repl" })
cc("SaveSession", cb.save_session, { nargs = "?", desc = "save session" })
cc("LoadSession", cb.load_session, { desc = "select a session to load" })
cc("DelSession", cb.delete_session, { desc = "select a session to delete" })
cc("ProjectConfig", cb.edit_project_config, { desc = "edit project config" })
cc("CreateTestFile", cb.create_test_file, { desc = "create test file" })
cc("Term", cb.open_terminal_for_current_dir, { desc = "open terminal for current dir" })
cac("FileType", { pattern = "go" ,callback = function ()
    bcc("CreateTestFileSetup", cb.create_setup_test_file, { desc = "create setup test file" })
    bcc("GoGenerate", cb.execute_go_generate, { desc = "execute go:generate" })
end})

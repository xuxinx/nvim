local cb = require('x.callbacks.command')

local cc = vim.api.nvim_create_user_command

cc('Note', cb.edit_note, { desc = 'edit note' })
cc('XNote', cb.edit_xnote, { desc = 'edit xnote' })
cc('Tmp', cb.edit_tmp, { desc = 'edit tmp' })
cc('Todo', cb.edit_todo, { desc = 'edit todo' })
cc('Z', cb.z_local_jump, { nargs = 1, desc = 'z local jump' })
cc('Zg', cb.z_global_jump, { nargs = 1, desc = 'z global jump' })
cc('OpenGit', cb.open_git, { desc = 'open git' })
cc('Rename', cb.rename_var, { desc = 'rename var' })
cc('DebugTest', cb.debug_test, { desc = 'debug test' })
cc('DebugScopes', cb.toggle_debug_scopes, { desc = 'toggle debug scopes' })
cc('DebugRepl', cb.toggle_debug_repl, { desc = 'toggle debug repl' })
cc('SaveSession', cb.save_session, { nargs = '?', desc = 'save session' })
cc('LoadSession', cb.load_session, { desc = 'select a session to load' })
cc('ProjectConfig', cb.edit_project_config, { desc = 'edit project config' })

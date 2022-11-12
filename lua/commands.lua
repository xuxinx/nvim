local cc = vim.api.nvim_create_user_command

cc('Note', function () vim.cmd('$tabe $HOME/xhome/notes/notes.md') end, {})
cc('XNote', function () vim.cmd('$tabe $HOME/xhome/notes/xnotes.md') end, {})
cc('Tmp', function () vim.cmd('$tabe $HOME/xhome/notes/tmp.txt') end, {})
cc('Todo', function () vim.cmd('$tabe $HOME/xhome/notes/todo.md') end, {})
cc('Z', function (opts) require'x.z'.z_navi('lcd', opts.args) end, { nargs = 1 })
cc('Zg', function (opts) require'x.z'.z_navi('cd', opts.args) end, { nargs = 1 })
cc('OpenGit', function () require'x.open_git'.open_git() end, {})
cc('Rename', function () vim.lsp.buf.rename() end, {})

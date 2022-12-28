local M = {}

function M.edit_note()
    vim.cmd('$tabe $HOME/xhome/notes/notes.md')
end

function M.edit_xnote()
    vim.cmd('$tabe $HOME/xhome/notes/xnotes.md')
end

function M.edit_tmp()
    vim.cmd('$tabe $HOME/xhome/notes/tmp.txt')
end

function M.edit_todo()
    vim.cmd('$tabe $HOME/xhome/notes/todo.md')
end

-- args
--   - path
function M.z_local_jump(opts)
    require('x.z').z_navi('lcd', opts.args)
end

-- args
--   - path
function M.z_global_jump(opts)
    require('x.z').z_navi('cd', opts.args)
end

function M.open_git()
    require('x.open_git').open_git()
end

function M.rename_var()
    vim.lsp.buf.rename()
end

function M.debug_test()
    require('x.dap_go').debug_test()
end

function M.toggle_debug_scopes()
    require('x.dap').scopes.toggle()
end

function M.toggle_debug_repl()
    require('dap').repl.toggle()
end

return M

local cb = require('x.callbacks.autocmd')

local cac = vim.api.nvim_create_autocmd

-- # filetype
cac({ 'BufNewFile', 'BufRead' }, { pattern = { '*.gohtml' },
    desc = 'set filetype to html',
    callback = cb.set_filetype_func('html') })

-- # indentations
cac('FileType', { pattern = { 'yaml', 'proto' },
    desc = 'set tab to 2 spaces',
    callback = cb.set_tab_to_n_spaces_func(2) })
cac('FileType', { pattern = { 'snippets' },
    desc = 'set tab length = 8 spaces',
    callback = cb.set_tab_to_n_spaces_func(8, false) })

-- # off syntax
cac({ 'BufNewFile', 'BufWinEnter' }, { pattern = { 'go.sum' },
    desc = 'off syntax',
    callback = cb.off_syntax })

-- # restore cursor
cac({ 'BufReadPost' }, {
    desc = 'restore cursor',
    callback = cb.restore_cursor
})

-- # statusline
cac('FileType', { pattern = { 'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes' },
    desc = 'dap window statusline',
    callback = cb.set_statusline_func('%f') })
cac('FileType', { pattern = 'dap-repl',
    desc = 'dap window statusline',
    callback = cb.set_statusline_func('DAP REPL') })
-- FIXME: why this is not work
cac('FileType', { pattern = 'dapui_console',
    desc = 'dap window statusline',
    callback = cb.set_statusline_func('DAP Console') })

-- # commentary
cac({ 'BufNewFile', 'BufRead' }, { pattern = { '*.mod', '*.work' },
    desc = 'set comment string',
    callback = cb.set_commentstring_func('// %s') })

-- # auto format
cac('BufWritePre', { pattern = '*.go',
    desc = 'auto format go',
    callback = cb.format_go })

-- # go
cac('BufNewFile', { pattern = '*.go',
    desc = 'new go template',
    callback = cb.new_go_file_tpl })

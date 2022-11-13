local cac = vim.api.nvim_create_autocmd

-- # filetype
cac({ 'BufNewFile', 'BufRead' },
    {
        desc = 'set filetype to html',
        pattern = { '*.gohtml' },
        callback = function()
            vim.bo.filetype = 'html'
        end,
    })

-- # indentations
cac('FileType',
    {
        desc = 'set tab to 2 space',
        pattern = { 'yaml', 'proto' },
        callback = function()
            vim.bo.tabstop = 2
            vim.bo.softtabstop = 2
            vim.bo.shiftwidth = 2
            vim.bo.expandtab = true
        end,
    })

-- # off syntax
cac({ 'BufNewFile', 'BufRead' },
    {
        desc = 'off syntax',
        pattern = { 'go.sum' },
        callback = function()
            vim.cmd('syntax off')
        end,
    })

-- # restore cursor
cac({ 'BufReadPost' },
    {
        desc = 'restore cursor',
        callback = function()
            require('x.restore_cursor').restore_cursor()
        end,
    })

-- # statusline
cac('FileType',
    {
        desc = 'dap window statusline',
        pattern = { 'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes' },
        callback = function()
            vim.wo.statusline = '%f'
        end,
    })
cac('FileType',
    {
        desc = 'dap window statusline',
        pattern = 'dap-repl',
        callback = function()
            vim.wo.statusline = 'DAP REPL'
        end,
    })
-- FIXME: why this is not work
cac('FileType',
    {
        desc = 'dap window statusline',
        pattern = 'dapui_console',
        callback = function()
            vim.wo.statusline = 'DAP Console'
        end,
    })

-- # commentary
cac({ 'BufNewFile', 'BufRead' },
    {
        desc = 'set comment string',
        pattern = { '*.mod', '*.work' },
        callback = function()
            vim.bo.commentstring = '// %s'
        end,
    })

-- # auto format
cac('BufWritePre',
    {
        desc = 'auto format go',
        pattern = '*.go',
        callback = function()
            require('x.go').goimports(1000)
        end,
    })

-- # go
cac('BufNewFile',
    {
        desc = 'new go template',
        pattern = '*.go',
        callback = function()
            require('x.go').new_file_tpl()
        end,
    })

local cac = vim.api.nvim_create_autocmd

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showcmd = true
vim.o.ruler = true
vim.o.mouse = 'a'
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.showmatch = true
vim.o.matchtime = 0
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99
vim.o.updatetime = 200
vim.o.scrolloff = 3
vim.o.grepprg = "rg --vimgrep --smart-case --hidden $*"
vim.o.grepformat = '%f:%l:%c:%m'
vim.o.splitright = true
vim.o.statusline = '%!v:lua.require\'x.statusline\'.statusline()'
vim.o.tabline = '%!v:lua.require\'x.tabline\'.tabline()'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.signcolumn = 'yes:2'
vim.o.termguicolors = true
vim.o.background = 'light'
vim.o.wildignore = vim.o.wildignore .. '.git,.DS_Store,.vscode,.idea,.local-history'

-- # netrw
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = 'nomodifiable nomodified number relativenumber nobuflisted nowrap readonly'

-- # filetype
cac({'BufNewFile', 'BufRead'}, { pattern = '*.gohtml' , callback = function () vim.bo.filetype = 'html' end})

-- # indentations
cac('FileType', { pattern = {'yaml', 'proto'} , callback = function ()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
end})

-- # off syntax
cac({'BufNewFile', 'BufRead'}, { pattern = 'go.sum' , callback = function () vim.cmd('syntax off') end})

-- # restore cursor
cac({'BufReadPost'}, { callback = function () require'x.restore_cursor'.restore_cursor() end})

-- # statusline
cac('FileType', { pattern = {'dapui_watches', 'dapui_stacks', 'dapui_breakpoints', 'dapui_scopes'} , callback = function () vim.wo.statusline='%f' end})
cac('FileType', { pattern = 'dap-repl' , callback = function () vim.wo.statusline='DAP REPL' end})
-- FIXME: why this is not work
cac('FileType', { pattern = 'dapui_console' , callback = function () vim.wo.statusline='DAP Console' end})

-- # commentary
cac({'BufNewFile', 'BufRead'}, { pattern = {'*.mod', '*.work'} , callback = function () vim.bo.commentstring='// %s' end})

-- # auto format
cac('BufWritePre', { pattern = '*.go' , callback = function () require'x.go'.goimports(1000) end})

-- # go
cac('BufNewFile', { pattern = '*.go' , callback = function () require'x.go'.new_file_tpl() end})

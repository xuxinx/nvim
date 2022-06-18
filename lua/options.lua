vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.cursorline = true
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
vim.o.grepprg = "ag --vimgrep --hidden --ignore={.git,.vscode,.idea,.local-history,node_modules,vendor,testdata/fuzz,'*.swp'} $*"
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
vim.cmd [[
augroup customFiletypes
    autocmd!
    autocmd BufNewFile,BufRead *.gohtml setlocal filetype=html
    autocmd BufNewFile,BufRead *.vue setlocal filetype=html
augroup end
]]

-- # indentations
vim.cmd [[
augroup customIndentations
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType proto setlocal ts=2 sts=2 sw=2 expandtab
augroup end
]]

-- # off syntax
vim.cmd [[
augroup customOffSyntax
    autocmd!
    autocmd BufNewFile,BufRead go.sum syntax off
augroup end
]]

-- # restore cursor
vim.cmd [[
augroup restorecursor
    autocmd!
    autocmd BufReadPost * lua require'x.restore_cursor'.restoreCursor()
augroup end
]]

-- # cursorline
vim.cmd [[
augroup cursorline
    autocmd!
    " TODO: is there a better way to check if win if Telescope popup
    autocmd VimEnter,WinEnter,BufWinEnter * if nvim_win_get_config(0).relative != 'editor' | setlocal cursorline | endif
    autocmd WinLeave * setlocal nocursorline
augroup end
]]

-- # statusline
vim.cmd [[
augroup statusline
    autocmd!
    autocmd FileType dapui_watches,dapui_stacks,dapui_breakpoints,dapui_scopes setlocal statusline=%f
    autocmd FileType dap-repl setlocal statusline=DAP\ REPL
    " TODO: why this is not work
    autocmd FileType dapui_console setlocal statusline=DAP\ Console
augroup end
]]

-- # commentary
vim.cmd [[
augroup customCommentary
    autocmd!
    autocmd BufNewFile,BufRead *.mod,*.work setlocal commentstring=//\ %s
augroup end
]]

-- # go
vim.cmd [[
augroup customGoExec
    autocmd!
    autocmd BufNewFile *.go lua require'x.go'.newFileTpl()
    autocmd BufWritePre *.go lua require'x.go'.goimports(1000)
augroup end
]]

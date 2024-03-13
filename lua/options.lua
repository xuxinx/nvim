vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.showcmd = true
vim.o.ruler = true
vim.o.mouse = "a"
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
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99
vim.o.updatetime = 200
vim.o.scrolloff = 3
vim.o.grepprg = "rg --vimgrep --smart-case --hidden $*"
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.splitright = true
vim.o.statusline = "%!v:lua.require'x.statusline'.statusline()"
vim.o.tabline = "%!v:lua.require'x.tabline'.tabline()"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.signcolumn = "yes:2"
vim.o.termguicolors = true
vim.o.background = "light"
vim.o.wildignore = vim.o.wildignore .. ".git,.DS_Store,.vscode,.idea,.local-history"
vim.o.jumpoptions = vim.o.jumpoptions .. "stack,view"
vim.o.laststatus = 3
-- vim.o.cmdheight = 0 -- too many bugs

-- # netrw
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = "nomodifiable nomodified number relativenumber nobuflisted nowrap readonly"

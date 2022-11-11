vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>co', '<cmd>copen<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>cclose<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files hidden=true no_ignore=true<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>Telescope live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fc', 'v:lua.require\'x.search_copied\'.searchCopied()', { noremap = true, expr = true })
-- # tab
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>$tabe<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>to', '<cmd>$tab<Space>split<CR>', { noremap = true })
-- # git
vim.api.nvim_set_keymap('n', ']c', '<cmd>Gitsigns next_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[c', '<cmd>Gitsigns prev_hunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hp', '<cmd>lua require"gitsigns".preview_hunk()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', { noremap = true })
-- # jump
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>HopChar1<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>j', '<cmd>HopChar1<CR>', { noremap = true })
-- # tag
vim.api.nvim_set_keymap('n', '<leader>tb', '<cmd>TagbarToggle<CR>', { noremap = true })
-- # lsp
-- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.api.nvim_set_keymap('n', '<leader>ca', [[<cmd>lua vim.lsp.buf.code_action()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>D', [[<cmd>lua vim.lsp.buf.hover()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fr', [[<cmd>lua require'telescope.builtin'.lsp_references()<CR>]], { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fi', [[<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>]], { noremap = true })
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)
vim.api.nvim_set_keymap('n', '<leader>lr', '<cmd>LspRestart<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ls', '<cmd>LspStart<CR>', { noremap = true })
-- # diagnostic
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true })
-- # dap
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F4>', '<cmd>lua require"dap".terminate()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><F5>', '<cmd>lua require"dap".run_to_cursor()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F7>', '<cmd>lua require"dap".step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F8>', '<cmd>lua require"dap".step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader><F8>', '<cmd>lua require"dap".step_out()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>K', '<cmd>lua require"dapui".eval()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dt', '<cmd>lua require("x.dap_go").debug_test()<CR>', { noremap = true })

vim.cmd [[
augroup xFiletypeMapping
    autocmd!
    " mark todo as done and add datetime
    autocmd FileType markdown nnoremap <buffer> <leader>tdd ^2f<Space>rx
    autocmd FileType markdown nnoremap <buffer> <leader>tdu ^fxr<Space>
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact,vue,css,less,scss,html,json,graphql,markdown,yaml nnoremap <buffer> <leader>F <Plug>(Prettier)
augroup end
]]

-- # commands
vim.cmd [[
command! -nargs=0 Note :$tabe $HOME/xhome/notes/notes.md
command! -nargs=0 XNote :$tabe $HOME/xhome/notes/xnotes.md
command! -nargs=0 Tmp :$tabe $HOME/xhome/notes/tmp.txt
command! -nargs=0 Todo :$tabe $HOME/xhome/notes/todo.md
command! -nargs=1 Z :call luaeval("require'x.z'.zNavi('lcd', _A)", <f-args>)
command! -nargs=1 Zg :call luaeval("require'x.z'.zNavi('cd', _A)", <f-args>)
command! -nargs=0 OpenGit lua require'x.open_git'.openGit()
command! -nargs=0 Rename lua vim.lsp.buf.rename()
]]

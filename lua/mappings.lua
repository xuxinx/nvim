local sm = vim.keymap.set
local cac = vim.api.nvim_create_autocmd

vim.g.mapleader = ' '

-- # quickfix list
sm('n', '<leader>co', function () vim.cmd('copen') end)
sm('n', '<leader>cc', function () vim.cmd('cclose') end)
-- # search file/string
sm('n', '<leader>ff', function () require'telescope.builtin'.find_files({hidden = true, no_ignore = true}) end)
sm('n', '<leader>fb', function () require'telescope.builtin'.buffers() end)
sm('n', '<leader>fs', function () require'telescope.builtin'.live_grep() end)
sm('n', '<leader>fc', function () return require'x.search_copied'.search_copied() end, { expr = true })
-- # tab
sm('n', '<leader>tt', function () vim.cmd("$tabe") end)
sm('n', '<leader>to', function () vim.cmd('$tab split') end)
-- # git
sm('n', ']c', function () require'gitsigns'.next_hunk() end)
sm('n', '[c', function () require'gitsigns'.prev_hunk() end)
sm('n', '<leader>gb', function() require'gitsigns'.blame_line{full=true} end)
sm('n', '<leader>hp', function() require'gitsigns'.preview_hunk() end)
sm('n', '<leader>hr', function() require'gitsigns'.reset_hunk() end)
-- # jump
sm({'n', 'v'}, '<leader>j', function () require'hop'.hint_char1() end)
-- # tag
sm('n', '<leader>tb', function () vim.cmd('TagbarToggle') end)
-- # lsp
sm('n', 'gd', function () vim.lsp.buf.definition() end)
sm('n', '<leader>ca', function () vim.lsp.buf.code_action() end)
sm('n', '<leader>D', function () vim.lsp.buf.hover() end)
sm('n', '<leader>fr', function () require'telescope.builtin'.lsp_references() end)
sm('n', '<leader>fi', function () require'telescope.builtin'.lsp_implementations() end)
local prettier_files = require'x.utils'.set({'javascript','javascriptreact','typescript','typescriptreact',
'vue','css','less','scss','html','json','graphql','markdown','yaml'})
sm('n', '<leader>F', function ()
    if prettier_files[vim.bo.filetype] then
        vim.cmd('Prettier')
    else
        vim.lsp.buf.format()
    end
end)
-- # diagnostic
sm('n', ']e', function () vim.diagnostic.goto_next() end)
sm('n', '[e', function () vim.diagnostic.goto_prev() end)
-- # dap
sm('n', '<leader>db', function () require'dap'.toggle_breakpoint() end)
sm('n', '<F4>', function () require'dap'.terminate() end)
sm('n', '<F5>', function () require'dap'.continue() end)
sm('n', '<leader><F5>', function () require'dap'.run_to_cursor() end)
sm('n', '<F7>', function () require'dap'.step_into() end)
sm('n', '<F8>', function () require'dap'.step_over() end)
sm('n', '<leader><F8>', function () require'dap'.step_out() end)
sm('n', '<leader>K', function () require'dapui'.eval() end)
sm('n', '<leader>dt', function() require'x.dap_go'.debug_test() end)
-- # markdown
cac('FileType', { pattern = 'markdown' , callback = function ()
    -- TODO: add datetime
    sm('n', '<leader>tdd', '^2f<Space>rx')
    sm('n', '<leader>tdu', '^fxr<Space>')
end})

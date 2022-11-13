local cb = require('x.callbacks.mapping')
local sm = vim.keymap.set
local cac = vim.api.nvim_create_autocmd

vim.g.mapleader = ' '

-- # quickfix list
sm('n', '<leader>co', cb.open_quickfix, { desc = 'open quickfix list' })
sm('n', '<leader>cc', cb.close_quickfix, { desc = 'close quickfix list' })
-- # search file/string
sm('n', '<leader>ff', cb.find_files, { desc = 'find files' })
sm('n', '<leader>fb', cb.find_buffers, { desc = 'find buffers' })
sm('n', '<leader>fs', cb.grep_string, { desc = 'find string' })
sm('n', '<leader>fc', cb.search_copied_expr, { expr = true, desc = 'find copied string' })
sm('n', '<leader>fh', cb.find_help_doc, { desc = 'find help doc' })
-- # tab
sm('n', '<leader>tt', cb.new_tab, { desc = 'new tab' })
sm('n', '<leader>to', cb.new_tab_with_current_buffer, { desc = 'new tab with current buffer' })
-- # git
sm('n', ']c', cb.next_changed_hunk, { desc = 'next git changed hunk' })
sm('n', '[c', cb.prev_changed_hunk, { desc = 'prev git changed hunk' })
sm('n', '<leader>gb', cb.blame_line, { desc = 'blame line' })
sm('n', '<leader>hp', cb.preview_changed_hunk, { desc = 'preview changed hunk' })
sm('n', '<leader>hr', cb.reset_changed_hunk, { desc = 'reset changed hunk' })
-- # jump
sm({ 'n', 'v' }, '<leader>j', cb.jump_to_char, { desc = 'jump to char' })
-- # tag
sm('n', '<leader>tb', cb.toggle_tagbar, { desc = 'toggle tagbar' })
-- # lsp
sm('n', 'gd', cb.code_definition, { desc = 'code definition' })
sm('n', '<leader>ca', cb.code_action, { desc = 'code action' })
sm('n', '<leader>D', cb.hover_code_doc, { desc = 'hover code doc' })
sm('n', '<leader>fr', cb.code_references, { desc = 'code references' })
sm('n', '<leader>fi', cb.implementations, { desc = 'interface implementations' })
sm('n', '<leader>F', cb.format_buffer, { desc = 'format buffer' })
-- # diagnostic
sm('n', ']e', cb.next_diagnostic, { desc = 'next diagnostic' })
sm('n', '[e', cb.prev_diagnostic, { desc = 'prev diagnostic' })
-- # dap
sm('n', '<leader>db', cb.toggle_breakpoint, { desc = 'toggle debug breakpoint' })
sm('n', '<F4>', cb.terminate_debug, { desc = 'terminate debug' })
sm('n', '<F5>', cb.start_continue_debug, { desc = 'start or continue debug' })
sm('n', '<leader><F5>', cb.run_to_cursor, { desc = 'debug run to cursor' })
sm('n', '<F7>', cb.step_into, { desc = 'debug step into' })
sm('n', '<F8>', cb.step_over, { desc = 'debug step over' })
sm('n', '<leader><F8>', cb.step_out, { desc = 'debug step out' })
sm('n', '<leader>K', cb.eval_cursor_var, { desc = 'debug eval cursor var' })
sm('n', '<leader>dt', cb.debug_test, { desc = 'debug test' })
-- # markdown
cac('FileType', { pattern = 'markdown', callback = function()
    sm('n', '<leader>tdd', cb.markdown_done_todo_expr, { expr = true, desc = 'markdown done todo' })
    sm('n', '<leader>tdu', cb.markdown_undone_todo_expr, { expr = true, desc = 'markdown undone todo' })
end })

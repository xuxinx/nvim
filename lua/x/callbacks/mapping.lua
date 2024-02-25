local utils = require('x.utils')

local M = {}

function M.open_quickfix()
    vim.cmd('copen')
end

function M.close_quickfix()
    vim.cmd('cclose')
end

function M.find_files()
    require('telescope.builtin').find_files({
        hidden = true,
        no_ignore = true,
    })
end

function M.find_buffers()
    require('telescope.builtin').buffers()
end

function M.grep_string()
    require('telescope.builtin').live_grep()
end

function M.search_copied_expr()
    return require('x.search_copied').search_copied()
end

function M.find_help_doc()
    return require('telescope.builtin').help_tags()
end

function M.new_tab()
    vim.cmd("$tabe")
end

function M.new_tab_with_current_buffer()
    vim.cmd('$tab split')
end

function M.next_changed_hunk()
    require('gitsigns').next_hunk()
end

function M.prev_changed_hunk()
    require('gitsigns').prev_hunk()
end

function M.blame_line()
    require('gitsigns').blame_line({ full = true })
end

function M.preview_changed_hunk()
    require('gitsigns').preview_hunk()
end

function M.reset_changed_hunk()
    require('gitsigns').reset_hunk()
end

function M.jump_to_char()
    require('hop').hint_char1()
end

function M.toggle_tagbar()
    vim.cmd('TagbarToggle')
end

function M.code_definition()
    vim.lsp.buf.definition()
end

function M.code_action()
    vim.lsp.buf.code_action()
end

function M.hover_code_doc()
    vim.lsp.buf.hover()
end

function M.code_references()
    require('telescope.builtin').lsp_references()
end

function M.implementations()
    require('telescope.builtin').lsp_implementations()
end

local prettier_files = utils.list_to_set({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
    'vue', 'css', 'less', 'scss', 'html', 'json', 'graphql', 'markdown', 'yaml' })
function M.format_buffer()
    if prettier_files[vim.bo.filetype] then
        vim.cmd('Prettier')
    else
        vim.lsp.buf.format()
    end
end

function M.next_diagnostic()
    vim.diagnostic.goto_next()
end

function M.prev_diagnostic()
    vim.diagnostic.goto_prev()
end

function M.snip_expand()
    local luasnip = require("luasnip")
    if luasnip.expandable() then
        luasnip.expand()
    end
end

function M.snip_jump_forward()
    local luasnip = require("luasnip")
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    end
end

function M.snip_jump_back()
    local luasnip = require("luasnip")
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end

function M.snip_toggle_choices()
    local luasnip = require("luasnip")
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end

function M.toggle_breakpoint()
    require('dap').toggle_breakpoint()
end

function M.terminate_debug()
    require('dap').terminate()
end

function M.start_continue_debug()
    require('dap').continue()
end

function M.run_to_cursor()
    require('dap').run_to_cursor()
end

function M.step_into()
    require('dap').step_into()
end

function M.step_over()
    require('dap').step_over()
end

function M.step_out()
    require('dap').step_out()
end

function M.markdown_done_todo_expr()
    return '$?- [<cr>2f<Space>rx<esc>/[C<cr>A [D ' .. os.date("%Y-%m-%d %H:%M %a") .. ']<esc>?- [<cr>:noh<cr>'
end

function M.markdown_undone_todo_expr()
    return '$?- [<cr>fxr<Space>/[D<cr>da[x?- [<cr>:noh<cr>'
end

M.netrw_create_test_file = function()
    local cursor_file = vim.api.nvim_get_current_line()
    local ext = utils.get_file_extension(cursor_file)
    local fname
    if ext == 'go' then
        fname = require('x.go').get_test_file_name(cursor_file)
    else
        vim.notify('file type of ' .. cursor_file .. ' is not supported', vim.log.levels.WARN)
        return
    end
    vim.cmd('e ' .. vim.fn.expand('%:p') .. fname)
end

return M

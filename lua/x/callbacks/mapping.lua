local utils = require("x.utils")

local M = {}

M.open_quickfix = function()
    vim.cmd("copen")
end

M.close_quickfix = function()
    vim.cmd("cclose")
end

M.find_files = function()
    require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true,
    })
end

M.find_buffers = function()
    require("telescope.builtin").buffers()
end

M.grep_string = function()
    require("telescope.builtin").live_grep()
end

M.search_copied_expr = function()
    return require("x.search_copied").search_copied()
end

M.find_help_doc = function()
    return require("telescope.builtin").help_tags()
end

M.new_tab = function()
    vim.cmd("$tabe")
end

M.new_tab_with_current_buffer = function()
    vim.cmd("$tab split")
end

M.next_changed_hunk = function()
    require("gitsigns").next_hunk()
end

M.prev_changed_hunk = function()
    require("gitsigns").prev_hunk()
end

M.blame_line = function()
    require("gitsigns").blame_line({ full = true })
end

M.preview_changed_hunk = function()
    require("gitsigns").preview_hunk()
end

M.reset_changed_hunk = function()
    require("gitsigns").reset_hunk()
end

M.jump_to_char = function()
    require("hop").hint_char1()
end

M.toggle_tagbar = function()
    vim.cmd("TagbarToggle")
end

M.code_definition = function()
    vim.lsp.buf.definition()
end

M.code_action = function()
    vim.lsp.buf.code_action()
end

M.hover_code_doc = function()
    vim.lsp.buf.hover()
end

M.code_references = function()
    require("telescope.builtin").lsp_references()
end

M.implementations = function()
    require("telescope.builtin").lsp_implementations()
end

local prettier_files = utils.list_to_set({ "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "css", "less", "scss", "html", "json", "graphql", "markdown", "yaml" })
M.format_buffer = function()
    if prettier_files[vim.bo.filetype] then
        vim.cmd("Prettier")
    else
        vim.lsp.buf.format()
    end
end

M.next_diagnostic = function()
    vim.diagnostic.goto_next()
end

M.prev_diagnostic = function()
    vim.diagnostic.goto_prev()
end

M.snip_expand = function()
    local luasnip = require("luasnip")
    if luasnip.expandable() then
        luasnip.expand()
    end
end

M.snip_jump_forward = function()
    local luasnip = require("luasnip")
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    end
end

M.snip_jump_back = function()
    local luasnip = require("luasnip")
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end

M.snip_toggle_choices = function()
    local luasnip = require("luasnip")
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end

M.toggle_breakpoint = function()
    require("dap").toggle_breakpoint()
end

M.terminate_debug = function()
    require("dap").terminate()
end

M.start_continue_debug = function()
    require("dap").continue()
end

M.run_to_cursor = function()
    require("dap").run_to_cursor()
end

M.step_into = function()
    require("dap").step_into()
end

M.step_over = function()
    require("dap").step_over()
end

M.step_out = function()
    require("dap").step_out()
end

M.markdown_done_todo_expr = function()
    return "$?- [<cr>2f<Space>rx<esc>/[C<cr>A [D " .. os.date("%Y-%m-%d %H:%M %a") .. "]<esc>?- [<cr>:noh<cr>"
end

M.markdown_undone_todo_expr = function()
    return "$?- [<cr>fxr<Space>/[D<cr>da[x?- [<cr>:noh<cr>"
end

M.netrw_create_test_file = function()
    local cursor_file = vim.api.nvim_get_current_line()
    local ext = utils.get_filename_extension(cursor_file)
    local fname
    if ext == "go" then
        fname = require("x.go").get_test_file_name(cursor_file)
    else
        vim.notify("file type of " .. cursor_file .. " is not supported", vim.log.levels.WARN)
        return
    end
    vim.cmd("e " .. vim.fn.expand("%:p") .. fname)
end

return M

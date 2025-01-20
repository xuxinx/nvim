local maps = {
    -- # file explorer
    { "n", "-", "<cmd>Oil<cr>", { desc = "open parent directory" } },
    {
        event = "FileType",
        pattern = "oil",
        { "n", "-", function() require("oil.actions").parent.callback() end, { buffer = true, desc = "up to parent dir" } },
        { "n", "<cr>", function() require("oil.actions").select.callback() end, { buffer = true, desc = "select the entry" } },
        { "n", "<C-6>", function() require("oil.actions").close.callback() end, { buffer = true, desc = "close oil" } },
        { "n", "gx", function() require("oil.actions").open_external.callback() end, { buffer = true, desc = "open the entry in external program" } },
        { "n", ",p", function() require("oil.actions").preview.callback() end, { buffer = true, desc = "toggle preview" } },
        { "n", ",y", function() require("oil.actions").yank_entry.callback({ modify = ":." }) end, { buffer = true, desc = "copy entry relative path" } },
        { "n", ",Y", function() require("oil.actions").yank_entry.callback() end, { buffer = true, desc = "copy entry full path" } },
        { "n", ",r", function() require("oil.actions").refresh.callback() end, { buffer = true, desc = "refresh list" } },
        { "n", ",h", function() require("oil.actions").toggle_hidden.callback() end, { buffer = true, desc = "toggle hidden" } },
        { "n", ",s", function() require("oil.actions").open_cmdline.callback() end, { buffer = true, desc = "open cmdline for file" } },
        { "n", ",S", function() require("oil.actions").open_cmdline_dir.callback() end, { buffer = true, desc = "open cmdline for dir" } },
        { "n", ",d", function() require("oil").discard_all_changes() end, { buffer = true, desc = "discard all changes" } },
        { "n", ",t", function() require("x.oil").open_trash() end, { buffer = true, desc = "open trash" } },
        { "n", ",c", function() require("x.oil").put_entry_to_ai_chat_context() end, { buffer = true, desc = "put entry to ai chat context" } },
    },
    -- # quickfix list
    { "n", "<leader>q", function() require("x.qflist").toggle() end, { desc = "toggle quickfix list" } },
    { "n", "]q", function() require("x.qflist").next() end, { desc = "next quickfix list item" } },
    { "n", "[q", function() require("x.qflist").prev() end, { desc = "prev quickfix list item" } },
    -- # search file/string
    { "n", "<leader>f", function() require("x.telescope").find_files() end, { desc = "find files" } },
    { "n", "<leader>b", function() require("telescope.builtin").buffers() end, { desc = "find buffers" } },
    { "n", "<leader>g", function() require("telescope.builtin").live_grep() end, { desc = "find by grep" } },
    { "n", "<leader>G", function() require("x.search_copied").search_copied() end, { expr = true, desc = "find copied string" } },
    { "n", "<F1>", function() require("telescope.builtin").help_tags() end, { desc = "find help doc" } },
    { { "n", "v" }, "<leader>c", function() require("telescope.builtin").commands() end, { desc = "find commands" } },
    -- # tab
    { "n", "<leader>t", "<cmd>$tabe<cr>", { desc = "new tab" } },
    { "n", "<leader>T", "<cmd>$tab split<cr>", { desc = "new tab with current buffer" } },
    -- # git
    { "n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "next git changed hunk" } },
    { "n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "prev git changed hunk" } },
    { "n", "<leader>B", function() require("gitsigns").blame_line({ full = true }) end, { desc = "blame line" } },
    { "n", "<leader>d", function() require("gitsigns").preview_hunk() end, { desc = "diff changed hunk" } },
    { "n", "<leader>u", function() require("gitsigns").reset_hunk() end, { desc = "reset changed hunk" } },
    -- # jump
    { { "n", "v" }, "<leader>j", "<cmd>HopPattern<cr>", { desc = "search pattern and jump" } },
    { "n", "<leader>/", "<cmd>noh<cr>", { desc = "stop search highlight" } },
    { "n", "<C-e>", "3<C-e>", { desc = "quicker C-e" } },
    { "n", "<C-y>", "3<C-y>", { desc = "quicker C-y" } },
    -- # lsp
    { "n", "gd", vim.lsp.buf.definition, { desc = "code definition" } },
    { "n", "<leader>a", vim.lsp.buf.code_action, { desc = "code action" } },
    { "n", "<leader>r", function() require("telescope.builtin").lsp_references({ include_current_line = true }) end, { desc = "code references" } },
    { "n", "<leader>i", function() require("telescope.builtin").lsp_implementations() end, { desc = "interface implementations" } },
    { "n", "<leader>F", function() require("x.format").format() end, { desc = "format buffer" } },
    { "n", "<leader>R", vim.lsp.buf.rename, { desc = "rename var" } },
    -- snip
    { { "i", "s" }, "<C-h>", function() require("x.luasnip").snip_expand() end, { desc = "snippet expand" } },
    { { "i", "s" }, "<C-j>", function() require("x.luasnip").snip_jump_forward() end, { desc = "snippet jump forward" } },
    { { "i", "s" }, "<C-k>", function() require("x.luasnip").snip_jump_back() end, { desc = "snippet jump back" } },
    { { "i", "s" }, "<C-l>", function() require("x.luasnip").snip_toggle_choices() end, { desc = "snippet toggle choices" } },
    -- # dap
    { "n", "<leader>8", function() require("dap").toggle_breakpoint() end, { desc = "toggle debug breakpoint" } },
    { "n", "<F4>", function() require("dap").terminate() end, { desc = "terminate debug" } },
    { "n", "<F5>", function() require("dap").continue() end, { desc = "start or continue debug" } },
    { "n", "<leader><F5>", function() require("x.dap").debug_test() end, { desc = "debug test" } },
    { "n", "<F6>", function() require("dap").run_to_cursor() end, { desc = "debug run to cursor" } },
    { "n", "<F7>", function() require("dap").step_into() end, { desc = "debug step into" } },
    { "n", "<F8>", function() require("dap").step_over() end, { desc = "debug step over" } },
    { "n", "<leader><F8>", function() require("dap").step_out() end, { desc = "debug step out" } },
    -- # table-mode
    { "n", "<leader>|", function() require("x.table_mode").toggle() end, { desc = "toggle table mode" } },
    -- # terminal
    { "t", "<c-[><c-[>", "<c-\\><c-n><cmd>bd!<cr>", { desc = "unload terminal buffer" } },
    { "n", "<bslash>t", function() require("x.terminal").open_terminal_for_current_dir() end, { desc = "open terminal for current dir" } },
    { "n", "<bslash>T", function() require("x.terminal").open_terminal_for_root_dir() end, { desc = "open terminal for root dir" } },
    -- # markdown
    {
        event = "FileType",
        pattern = "markdown",
        { "n", ",x", function() require("x.markdown").toggle_todo() end, { buffer = true, desc = "toggle markdown todo" } },
    },
    -- # text operations
    { "n", "<leader>s1", function() require("x.swap").swap_list_items(1) end, { desc = "swap list item 1" } },
    { "n", "<leader>s2", function() require("x.swap").swap_list_items(2) end, { desc = "swap list item 2" } },
    { "n", "<leader>s3", function() require("x.swap").swap_list_items(3) end, { desc = "swap list item 3" } },
    { "n", "<leader>s4", function() require("x.swap").swap_list_items(4) end, { desc = "swap list item 4" } },
    { "n", "<leader>s5", function() require("x.swap").swap_list_items(5) end, { desc = "swap list item 5" } },
    { "n", "<leader>s6", function() require("x.swap").swap_list_items(6) end, { desc = "swap list item 6" } },
    { "n", "<leader>s7", function() require("x.swap").swap_list_items(7) end, { desc = "swap list item 7" } },
    { "n", "<leader>s8", function() require("x.swap").swap_list_items(8) end, { desc = "swap list item 8" } },
    { "n", "<leader>s9", function() require("x.swap").swap_list_items(9) end, { desc = "swap list item 9" } },
    { "n", "<leader>l", function() require("x.list_format").toggle() end, { desc = "toggle list format" } },
    { "n", "<leader>w", function() return require("x.strcase").to_lower_camel() or require("x.strcase").to_snake() end, { desc = "toggle snake and lower camel" } },
    { "n", "<leader>W", function() return require("x.strcase").to_camel() or require("x.strcase").to_snake() end, { desc = "toggle snake and camel" } },
    -- # session
    { "n", "<bslash>s", function() require("x.session").load_session(require("x.session").auto_session_name) end, { desc = "load default session" } },
    -- # tags
    { "n", "<leader>;", "<cmd>TagbarToggle f<cr>", { desc = "toggle tagbar" } },
    -- # ai
    { { "n", "v" }, "<bslash>c", "<cmd>CopilotChatToggle<cr>", { desc = "toggle AI chat" } },
    {
        event = "FileType",
        pattern = "copilot-chat",
        -- ,a: accept diff
        { "n", ",e", function() require("CopilotChat").ask("/Explain") end, { buffer = true, desc = "explain the selected code" } },
        { "n", ",r", function() require("CopilotChat").ask("/Review") end, { buffer = true, desc = "review the selected code" } },
        { "n", ",f", function() require("CopilotChat").ask("/Fix") end, { buffer = true, desc = "fix the selected code" } },
        { "n", ",o", function() require("CopilotChat").ask("/Optimize") end, { buffer = true, desc = "optimize the selected code" } },
        { "n", ",d", function() require("CopilotChat").ask("/Docs") end, { buffer = true, desc = "add doc comment to the selected code" } },
        { "n", ",t", function() require("CopilotChat").ask("/Tests") end, { buffer = true, desc = "generate tests" } },
        { "n", ",c", function() require("CopilotChat").ask("/Commit") end, { buffer = true, desc = "generate git commit message" } },
    },
    -- # rest client
    {
        event = "FileType",
        pattern = "http",
        { "n", ",r", function() require('kulala').run() end, { buffer = true, desc = "run request" } },
        { "n", ",R", function() require('kulala').run_all() end, { buffer = true, desc = "run all requests" } },
        { "n", ",f", function() require("x.kulala").find_rest() end, { buffer = true, desc = "find rest" } },
        { "n", ",F", function() require("x.kulala").grep_rest() end, { buffer = true, desc = "grep rest" } },
        { "n", ",e", function() require('kulala').copy() end, { buffer = true, desc = "export request to cURL" } },
        { "n", ",i", function() require('kulala').from_curl() end, { buffer = true, desc = "import request from cURL" } },
        { "n", ",d", function() require('kulala').inspect() end, { buffer = true, desc = "show parsed request" } },
    },
}

local group = vim.api.nvim_create_augroup("x_augroup_mappings", { clear = true })
for _, m in ipairs(maps) do
    if m.event ~= nil then
        vim.api.nvim_create_autocmd(m.event, {
            group = group,
            pattern = m.pattern,
            callback = function()
                for _, em in ipairs(m) do
                    vim.keymap.set(em[1], em[2], em[3], em[4])
                end
            end
        })
    else
        vim.keymap.set(m[1], m[2], m[3], m[4])
    end
end

local xls = require("x.luasnip")
local oil_actions = require("oil.actions")
local xoil = require("x.oil")
local swap = require("x.swap")
local session = require("x.session")
local strcase = require("x.strcase")
local chat = require("CopilotChat")

local maps = {
    -- # file explorer
    { "n", "-", "<cmd>Oil<cr>", { desc = "open parent directory" } },
    {
        event = "FileType",
        pattern = "oil",
        { "n", "-", oil_actions.parent.callback, { buffer = true, desc = "up to parent dir" } },
        { "n", "<cr>", oil_actions.select.callback, { buffer = true, desc = "select the entry" } },
        { "n", "<C-6>", oil_actions.close.callback, { buffer = true, desc = "close oil" } },
        { "n", "gx", oil_actions.open_external.callback, { buffer = true, desc = "open the entry in external program" } },
        { "n", ",p", oil_actions.preview.callback, { buffer = true, desc = "toggle preview" } },
        { "n", ",y", function() oil_actions.yank_entry.callback({ modify = ":." }) end, { buffer = true, desc = "copy entry relative path" } },
        { "n", ",Y", oil_actions.yank_entry.callback, { buffer = true, desc = "copy entry full path" } },
        { "n", ",c", xoil.put_entry_to_ai_chat_context, { buffer = true, desc = "put entry to ai chat context" } },
    },
    -- # quickfix list
    { "n", "<leader>q", require("x.qflist").toggle, { desc = "toggle quickfix list" } },
    { "n", "]q", require("x.qflist").next, { desc = "next quickfix list item" } },
    { "n", "[q", require("x.qflist").prev, { desc = "prev quickfix list item" } },
    -- # search file/string
    { "n", "<leader>f", require("x.telescope").find_files, { desc = "find files" } },
    { "n", "<leader>b", require("telescope.builtin").buffers, { desc = "find buffers" } },
    { "n", "<leader>g", require("telescope.builtin").live_grep, { desc = "find by grep" } },
    { "n", "<leader>G", require("x.search_copied").search_copied, { expr = true, desc = "find copied string" } },
    { "n", "<F1>", require("telescope.builtin").help_tags, { desc = "find help doc" } },
    { { "n", "v" }, "<leader>c", require("telescope.builtin").commands, { desc = "find commands" } },
    -- # tab
    { "n", "<leader>t", "<cmd>$tabe<cr>", { desc = "new tab" } },
    { "n", "<leader>T", "<cmd>$tab split<cr>", { desc = "new tab with current buffer" } },
    -- # git
    { "n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "next git changed hunk" } },
    { "n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "prev git changed hunk" } },
    { "n", "<leader>B", function() require("gitsigns").blame_line({ full = true }) end, { desc = "blame line" } },
    { "n", "<leader>d", require("gitsigns").preview_hunk, { desc = "diff changed hunk" } },
    { "n", "<leader>u", require("gitsigns").reset_hunk, { desc = "reset changed hunk" } },
    -- # jump
    { { "n", "v" }, "<leader>j", "<cmd>HopPattern<cr>", { desc = "search pattern and jump" } },
    { "n", "<leader>/", "<cmd>noh<cr>", { desc = "stop search highlight" } },
    { "n", "<C-e>", "3<C-e>", { desc = "quicker C-e" } },
    { "n", "<C-y>", "3<C-y>", { desc = "quicker C-y" } },
    -- # lsp
    { "n", "gd", vim.lsp.buf.definition, { desc = "code definition" } },
    { "n", "<leader>a", vim.lsp.buf.code_action, { desc = "code action" } },
    { "n", "<leader>r", function() require("telescope.builtin").lsp_references({ include_current_line = true }) end, { desc = "code references" } },
    { "n", "<leader>i", require("telescope.builtin").lsp_implementations, { desc = "interface implementations" } },
    { "n", "<leader>F", require("x.format").format, { desc = "format buffer" } },
    { "n", "<leader>R", vim.lsp.buf.rename, { desc = "rename var" } },
    -- snip
    { { "i", "s" }, "<C-h>", xls.snip_expand, { desc = "snippet expand" } },
    { { "i", "s" }, "<C-j>", xls.snip_jump_forward, { desc = "snippet jump forward" } },
    { { "i", "s" }, "<C-k>", xls.snip_jump_back, { desc = "snippet jump back" } },
    { { "i", "s" }, "<C-l>", xls.snip_toggle_choices, { desc = "snippet toggle choices" } },
    -- # dap
    { "n", "<leader>8", require("dap").toggle_breakpoint, { desc = "toggle debug breakpoint" } },
    { "n", "<F4>", require("dap").terminate, { desc = "terminate debug" } },
    { "n", "<F5>", require("dap").continue, { desc = "start or continue debug" } },
    { "n", "<leader><F5>", require("x.dap").debug_test, { desc = "debug test" } },
    { "n", "<F6>", require("dap").run_to_cursor, { desc = "debug run to cursor" } },
    { "n", "<F7>", require("dap").step_into, { desc = "debug step into" } },
    { "n", "<F8>", require("dap").step_over, { desc = "debug step over" } },
    { "n", "<leader><F8>", require("dap").step_out, { desc = "debug step out" } },
    -- # table-mode
    { "n", "<leader>|", require("x.table_mode").toggle, { desc = "toggle table mode" } },
    -- # terminal
    { "t", "<c-[><c-[>", "<c-\\><c-n><cmd>bd!<cr>", { desc = "unload terminal buffer" } },
    { "n", "<bslash>t", require("x.terminal").open_terminal_for_current_dir, { desc = "open terminal for current dir" } },
    { "n", "<bslash>T", require("x.terminal").open_terminal_for_root_dir, { desc = "open terminal for root dir" } },
    -- # markdown
    {
        event = "FileType",
        pattern = "markdown",
        { "n", ",x", require("x.markdown").toggle_todo, { buffer = true, desc = "toggle markdown todo" } },
    },
    -- # text operations
    { "n", "<leader>s1", function() swap.swap_list_items(1) end, { desc = "swap list item 1" } },
    { "n", "<leader>s2", function() swap.swap_list_items(2) end, { desc = "swap list item 2" } },
    { "n", "<leader>s3", function() swap.swap_list_items(3) end, { desc = "swap list item 3" } },
    { "n", "<leader>s4", function() swap.swap_list_items(4) end, { desc = "swap list item 4" } },
    { "n", "<leader>s5", function() swap.swap_list_items(5) end, { desc = "swap list item 5" } },
    { "n", "<leader>s6", function() swap.swap_list_items(6) end, { desc = "swap list item 6" } },
    { "n", "<leader>s7", function() swap.swap_list_items(7) end, { desc = "swap list item 7" } },
    { "n", "<leader>s8", function() swap.swap_list_items(8) end, { desc = "swap list item 8" } },
    { "n", "<leader>s9", function() swap.swap_list_items(9) end, { desc = "swap list item 9" } },
    { "n", "<leader>l", require("x.list_format").toggle, { desc = "toggle list format" } },
    { "n", "<leader>w", function() return strcase.to_lower_camel() or strcase.to_snake() end, { desc = "toggle snake and lower camel" } },
    { "n", "<leader>W", function() return strcase.to_camel() or strcase.to_snake() end, { desc = "toggle snake and camel" } },
    -- # session
    { "n", "<bslash>s", function() session.load_session(session.auto_session_name) end, { desc = "load default session" } },
    -- # tags
    { "n", "<leader>;", "<cmd>TagbarToggle f<cr>", { desc = "toggle tagbar" } },
    -- # ai
    { { "n", "v" }, "<bslash>c", "<cmd>CopilotChatToggle<cr>", { desc = "toggle AI chat" } },
    {
        event = "FileType",
        pattern = "copilot-chat",
        -- ,a: accept diff
        { "n", ",e", function() chat.ask("/Explain") end, { buffer = true, desc = "explain the selected code" } },
        { "n", ",r", function() chat.ask("/Review") end, { buffer = true, desc = "review the selected code" } },
        { "n", ",f", function() chat.ask("/Fix") end, { buffer = true, desc = "fix the selected code" } },
        { "n", ",o", function() chat.ask("/Optimize") end, { buffer = true, desc = "optimize the selected code" } },
        { "n", ",d", function() chat.ask("/Docs") end, { buffer = true, desc = "add doc comment to the selected code" } },
        { "n", ",t", function() chat.ask("/Tests") end, { buffer = true, desc = "generate tests" } },
        { "n", ",c", function() chat.ask("/Commit") end, { buffer = true, desc = "generate git commit message" } },
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

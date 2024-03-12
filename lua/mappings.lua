local xls = require("x.luasnip")
local oil_actions = require("oil.actions")

local sm = vim.keymap.set
local group = vim.api.nvim_create_augroup("x_augroup_mappings", { clear = true })
local cac = function(event, opts)
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
end


-- # file explorer
sm("n", "-", "<cmd>Oil<cr>", { desc = "open parent directory" })
cac("FileType", {
    pattern = "oil",
    callback = function()
        sm("n", "-", oil_actions.parent.callback, { buffer = true, desc = "up to parent dir" })
        sm("n", "<cr>", oil_actions.select.callback, { buffer = true, desc = "select the entry" })
        sm("n", "<leader>p", oil_actions.preview.callback, { buffer = true, desc = "toggle preview" })
        sm("n", "<C-6>", oil_actions.close.callback, { buffer = true, desc = "close oil" })
        sm("n", "gx", oil_actions.open_external.callback, { buffer = true, desc = "open the entry in external program" })
    end
})
-- # quickfix list
sm("n", "<leader>co", "<cmd>copen<cr>", { desc = "open quickfix list" })
sm("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "close quickfix list" })
-- # search file/string
sm("n", "<leader>ff", require("x.telescope").find_files, { desc = "find files" })
sm("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "find buffers" })
sm("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "find by grep" })
sm("n", "<leader>fc", require("x.search_copied").search_copied, { expr = true, desc = "find copied string" })
sm("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "find help doc" })
sm("n", "<leader>lc", require("telescope.builtin").commands, { desc = "list(find) commands" })
-- # tab
sm("n", "<leader>tt", "<cmd>$tabe<cr>", { desc = "new tab" })
sm("n", "<leader>to", "<cmd>$tab split<cr>", { desc = "new tab with current buffer" })
-- # git
sm("n", "]c", require("gitsigns").next_hunk, { desc = "next git changed hunk" })
sm("n", "[c", require("gitsigns").prev_hunk, { desc = "prev git changed hunk" })
sm("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "blame line" })
sm("n", "<leader>hp", require("gitsigns").preview_hunk, { desc = "preview changed hunk" })
sm("n", "<leader>hr", require("gitsigns").reset_hunk, { desc = "reset changed hunk" })
-- # jump
sm({ "n", "v" }, "<leader>j", function() require("hop").hint_char1() end, { desc = "jump to char" })
-- # lsp
sm("n", "gd", vim.lsp.buf.definition, { desc = "code definition" })
sm("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
sm("n", "<leader>D", vim.lsp.buf.hover, { desc = "hover code doc" })
sm("n", "<leader>fr", require("telescope.builtin").lsp_references, { desc = "code references" })
sm("n", "<leader>fi", require("telescope.builtin").lsp_implementations, { desc = "interface implementations" })
sm("n", "<leader>F", require("x.prettier").format, { desc = "format buffer" })
-- # diagnostic
sm("n", "]e", vim.diagnostic.goto_next, { desc = "next diagnostic" })
sm("n", "[e", vim.diagnostic.goto_prev, { desc = "prev diagnostic" })
-- snip
sm({ "i", "s" }, "<C-h>", xls.snip_expand, { desc = "snippet expand" })
sm({ "i", "s" }, "<C-j>", xls.snip_jump_forward, { desc = "snippet jump forward" })
sm({ "i", "s" }, "<C-k>", xls.snip_jump_back, { desc = "snippet jump back" })
sm({ "i", "s" }, "<C-l>", xls.snip_toggle_choices, { desc = "snippet toggle choices" })
-- # dap
sm("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "toggle debug breakpoint" })
sm("n", "<F4>", require("dap").terminate, { desc = "terminate debug" })
sm("n", "<F5>", require("dap").continue, { desc = "start or continue debug" })
sm("n", "<leader><F5>", require("dap").run_to_cursor, { desc = "debug run to cursor" })
sm("n", "<F7>", require("dap").step_into, { desc = "debug step into" })
sm("n", "<F8>", require("dap").step_over, { desc = "debug step over" })
sm("n", "<leader><F8>", require("dap").step_out, { desc = "debug step out" })
-- # markdown
cac("FileType", {
    pattern = "markdown",
    callback = function()
        sm("n", "<leader>tdd", "mk$?- [<cr>2f<Space>rx`k:noh<cr>", { buffer = true, desc = "markdown done todo" })
        sm("n", "<leader>tdu", "mk$?- [<cr>fxr<Space>`k:noh<cr>", { buffer = true, desc = "markdown undone todo" })
    end
})

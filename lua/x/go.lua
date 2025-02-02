local utils = require("x.utils")

local M = {}

local zero_values = {
    int = "0",
    bool = "false",
    string = [[""]],
}

utils.set_same_value_entries(zero_values, "int",
    "int8", "int16", "int32", "int64",
    "uint", "uint8", "uint16", "uint32", "uint64",
    "float32", "float64")

M.zero_values = zero_values

-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-616844477
M.goimports = function(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end

    vim.lsp.buf.format({
        timeout_ms = wait_ms,
        async = false,
    })
end

M.new_file_tpl = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if vim.fn.getfsize(buf_name) > 0 then
        return
    end

    local ls = require("luasnip")
    local xls = require("x.luasnip")

    local package_name
    local fname = vim.fs.basename(buf_name)
    local is_main = fname == "main.go"
    if is_main or vim.fn.filereadable(vim.fs.dirname(buf_name) .. "/main.go") == 1 then
        package_name = "main"
    else
        package_name = utils.get_curr_dir_name()
    end
    vim.fn.append(0, "package " .. package_name)
    vim.fn.append(1, "")
    vim.api.nvim_win_set_cursor(0, { 3, 1 })
    local snippets = xls.get_snippet_map("go")
    if is_main then
        ls.snip_expand(snippets["main"])
    elseif fname == "setup_test.go" then
        ls.snip_expand(snippets["testmain"])
    end
end

return M

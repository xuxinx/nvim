local utils = require("x.utils")

local M = {}

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
    local package_name
    local buf_name = vim.api.nvim_buf_get_name(0)
    local is_main = vim.fs.basename(buf_name) == "main.go"
    if is_main or vim.fn.filereadable(vim.fs.dirname(buf_name) .. "/main.go") == 1 then
        package_name = "main"
    else
        package_name = utils.get_curr_dir_name()
    end
    vim.fn.append(0, "package " .. package_name)
    vim.fn.append(1, "")
    if is_main then
        vim.fn.append(2, "func main() {")
        vim.fn.append(3, "}")
        vim.api.nvim_win_set_cursor(0, { 3, 0 })
        -- FIXME: lsp not work before calling write
        vim.api.nvim_input("o")
    end
end

M.get_test_file_name = function(target_file)
    return utils.remove_filename_extension(target_file) .. "_test.go"
end

return M

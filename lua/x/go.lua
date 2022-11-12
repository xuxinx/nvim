local M = {}

-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-616844477
function M.goimports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, 'utf-16')
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

function M.new_file_tpl()
    vim.fn.append(0, 'package ' .. require'x.utils'.curr_dir())
    vim.fn.append(1, '')
end

return M

local M = {}

M.new_pnvim_file = function ()
    vim.api.nvim_buf_set_lines(0, 0, 0, true, {
'PCFG = {',
'    telescope = {',
'        ignore_dirs = {},',
'        ignore_file_extensions = {},',
'        ignore_files = {},',
'        ignore_free_patterns = {},',
'    }',
'}',
    })
end

return M

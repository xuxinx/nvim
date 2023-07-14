P = function(v)
    print(vim.inspect(v))
    return v
end

-- project scope config
PCFG = {}
local PCFG_default = {
    telescope = {
        ignore_dirs = {},
        ignore_file_extensions = {},
        ignore_files = {},
        ignore_free_patterns = {},
    }
}
local project_nvim_config_filepath = vim.fn.getcwd() .. '/pnvim.lua'
if vim.fn.filereadable(project_nvim_config_filepath) == 1 then
    vim.cmd('luafile ' .. project_nvim_config_filepath)
end
PCFG = vim.tbl_deep_extend('force', PCFG_default, PCFG)

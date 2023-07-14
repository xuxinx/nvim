local utils = require('x.utils')

local ignore_dirs = utils.merge_arrays({
    '.git',
    '.vscode',
    '.idea',
    '.local-history',
    'node_modules',
    'testdata/fuzz',
    'vendor',
    'dist',
}, PCFG.telescope.ignore_dirs)
local ignore_file_extensions = utils.merge_arrays({
    '.swp',
    '.min.js',
    '.min.css',
}, PCFG.telescope.ignore_file_extensions)
local ignore_files = utils.merge_arrays({
    '.DS_Store',
}, PCFG.telescope.ignore_files)
local ignore_free_patterns = utils.merge_arrays({
}, PCFG.telescope.ignore_free_patterns)

local file_ignore_patterns = {}

for _, v in pairs(ignore_dirs) do
    local p = v:gsub('([.-])', '%%%1') .. '/'
    table.insert(file_ignore_patterns, '^' .. p)
    table.insert(file_ignore_patterns, '/' .. p)
end
for _, v in pairs(ignore_file_extensions) do
    local p = v:gsub('([.-])', '%%%1') .. '$'
    table.insert(file_ignore_patterns, p)
end
for _, v in pairs(ignore_files) do
    local p = v:gsub('([.-])', '%%%1') .. '$'
    table.insert(file_ignore_patterns, '^' .. p)
    table.insert(file_ignore_patterns, '/' .. p)
end
for _, v in pairs(ignore_free_patterns) do
    table.insert(file_ignore_patterns, v)
end

require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
        },
        file_ignore_patterns = file_ignore_patterns,
    },
    pickers = {
        buffers = {
            ignore_current_buffer = false,
            sort_mru = true,
            sort_lastused = true,
        },
    },
}

require('telescope').load_extension('fzf')

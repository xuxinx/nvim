local ignore_dirs = {
    '.git',
    '.vscode',
    '.idea',
    '.local-history',
    'node_modules',
    'testdata/fuzz',
    'vendor',
    'dist',
}
local ignore_file_extensions = {
    '.swp',
    '.min.js',
    '.min.css',
}

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

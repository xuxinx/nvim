local ignoreDirs = {
    '.git',
    '.vscode',
    '.idea',
    '.local-history',
    'node_modules',
    'testdata/fuzz',
    'vendor',
    'dist',
}
local ignoreFileExtensions = {
    '.swp',
    '.min.js',
    '.min.css',
}

local fileIgnorePatterns = {}

for  _, v in pairs(ignoreDirs) do
    local p = v:gsub('([.-])', '%%%1') .. '/'
    table.insert(fileIgnorePatterns, '^' .. p)
    table.insert(fileIgnorePatterns, '/' .. p)
end
for  _, v in pairs(ignoreFileExtensions) do
    local p = v:gsub('([.-])', '%%%1') .. '$'
    table.insert(fileIgnorePatterns, p)
end

require('telescope').setup{
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
        file_ignore_patterns = fileIgnorePatterns,
    },
    pickers = {
        buffers = {
            ignore_current_buffer = false,
            sort_mru = true,
            sort_lastused = true,
        },
    },
}

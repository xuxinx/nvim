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
        file_ignore_patterns = {
            '.git/',
            '.vscode/',
            '.idea/',
            '.local%-history/',
            'node_modules/',
            'testdata/fuzz/',
            'vendor/',
            '*.swp',
        },
    },
    pickers = {
        buffers = {
            ignore_current_buffer = false,
            sort_mru = true,
            sort_lastused = true,
        },
    },
}

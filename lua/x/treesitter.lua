require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'go', 'gomod', 'gowork', 'graphql',
        'html', 'javascript', 'json', 'lua', 'proto', 'python', 'regex',
        'ruby', 'rust', 'scss', 'tsx', 'typescript', 'vim', 'vue', 'yaml',
    },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

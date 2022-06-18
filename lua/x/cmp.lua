vim.g.vsnip_snippet_dir = vim.fn.stdpath('config')..'/vsnip'

require'cmp'.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    sources = require'cmp'.config.sources{
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'vsnip' },
    },
})

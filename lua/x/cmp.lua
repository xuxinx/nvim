local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    sources = require'cmp'.config.sources{
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'ultisnips' },
    },
    mapping = require'cmp.config.mapping'.preset.insert()
})

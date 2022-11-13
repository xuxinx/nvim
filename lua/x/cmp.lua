local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, buf in ipairs(vim.fn.tabpagebuflist()) do
                        bufs[buf] = true
                    end
                    print(vim.inspect(bufs))
                    return vim.tbl_keys(bufs)
                end,
            },
        },
        { name = 'path' },
        { name = 'ultisnips' },
    }),
    mapping = require('cmp.config.mapping').preset.insert()
})

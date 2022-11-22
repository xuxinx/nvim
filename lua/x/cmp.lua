local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
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
                    return vim.tbl_keys(bufs)
                end,
            },
        },
        { name = 'path' },
        { name = 'luasnip' },
    }),
    mapping = require('cmp.config.mapping').preset.insert({
        ['<C-j>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-k>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    })
})

require("luasnip.loaders.from_snipmate").lazy_load()

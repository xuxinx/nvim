local M = {}

M.setup = function()
    local cmp = require("cmp")

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            {
                name = "buffer",
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
            { name = "path" },
            { name = "luasnip" },
        }),
        mapping = require("cmp.config.mapping").preset.insert({})
    })
end

return M

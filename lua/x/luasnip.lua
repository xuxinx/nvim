local ls = require("luasnip")
local types = require("luasnip.util.types")

local M = {}

M.setup = function()
    ls.setup({
        history = true,
        update_events = "TextChanged,TextChangedI",
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    hl_group = "@text.diff.add",
                },
            },
        }
    })

    require("luasnip.loaders.from_snipmate").lazy_load()
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
end

return M

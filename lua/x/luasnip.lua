local utils = require("x.utils")
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
    require("luasnip.loaders.from_lua").load({ paths = utils.join_path(vim.fn.stdpath("config"), "snippets") })
end

M.get_snippet_map = function(ft)
    local result = {}
    local snippets = ls.get_snippets(ft)
    for _, snip in pairs(snippets) do
        result[snip.trigger] = snip
    end
    return result
end

M.snip_expand = function()
    if ls.expandable() then
        ls.expand()
    end
end

M.snip_jump_forward = function()
    if ls.jumpable(1) then
        ls.jump(1)
    end
end

M.snip_jump_back = function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

M.snip_toggle_choices = function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end

return M

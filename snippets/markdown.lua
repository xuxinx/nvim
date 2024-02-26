local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    -- todo
    s({ trig = "^%s*(%d?)td", regTrig = true }, fmt([[
<tabs>- [ ] <todo>
      ]], {
        todo = i(1, "todo"),
        tabs = f(function(_, snip)
            if snip.captures[1] == "" then
                return
            end
            return string.rep(" ", snip.captures[1])
        end),
    })),
}

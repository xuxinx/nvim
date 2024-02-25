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
    s({ trig = "^%s*td", regTrig = true }, fmt([[
- [ ] <todo>  
  [C <datetime>]
      ]], {
        todo = i(1, "todo"),
        datetime = f(function()
            return os.date("%Y-%m-%d %H:%M %a")
        end),
    })),
}


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
    -- test
    s("test", {
        t("t1"),
        c(1, { t("c1t1"), t("c1t2") }),
        t("t2"),
        i(2, "hoho"),
        t("t3"),
    }),

    -- boilerplate
    s("sp", fmt([[
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
    <body>
}
]]   , {
        body = i(1),
    })),
}

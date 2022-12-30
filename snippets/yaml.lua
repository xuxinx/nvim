local ls = require('luasnip')
local s = ls.s
local i = ls.i
local t = ls.t
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
    -- new memo
    s({ trig = '^%s*memo', regTrig = true },
        {
            t({
                '    - tags:',
                '        - ',
            }),
            i(1, ''),
            t({
                '',
                '      question: ',
            }),
            i(2, ''),
            t({
                '',
                '      desc: ',
            }),
            i(3, ''),
            t({
                '',
                '      answer: |-',
                '        ',
            }),
            i(4, ''),
        }
    ),
    -- new english memo
    s({ trig = '^%s*ememo', regTrig = true },
        {
            t({
                '    - tags:',
                '        - English',
            }),
            t({
                '',
                '      question: 译：',
            }),
            i(1, ''),
            t({
                '',
                '      desc: ',
            }),
            t({
                '',
                '      answer: |-',
                '        ',
            }),
            i(2, ''),
        }
    ),
}

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
local xgo = require("x.go")
local xts = require("x.treesitter")

return {
    s("pkd", t('import _ "github.com/lib/pq"')),
    s("pkl", t('import kitlog "github.com/theplant/appkit/log"')),
    s("pkh", t('import h "github.com/theplant/htmlgo"')),
    s("pkv", t('import . "github.com/qor5/ui/vuetify"')),
    s("pkvx", t('import vx "github.com/qor5/ui/vuetifyx"')),

    -- cases test
    s("ct", fmt([[
	func Test<func>(t *testing.T) {
		for _, c := range []struct {
			name string
			<expect> <expect_type>
		}{
			{},
		}{
			t.Run(c.name, func(t *testing.T) {
				if diff := cmp.Diff(c.<expect_rep>, <func_rep>()); diff != "" {
					t.Fatalf("got diff %s\n", diff)
				}
			})
		}
	}
    ]], {
        func = i(1, "func"),
        expect = i(2, "expect"),
        expect_type = i(3, "type"),
        expect_rep = rep(2),
        func_rep = rep(1),
    })),

    -- debug print
    s("dp", fmt([[
	fmt.Println("#########################################start")
	testingutils.PrintlnJson(<args>)
	fmt.Println("#########################################end")
    ]], {
        args = i(1),
    })),

    -- http handler
    s("hh", fmt([[
	func(w http.ResponseWriter, r *http.Request) {
        <body>
	}
    ]], {
        body = i(1, "body"),
    })),

    -- set debug env
    s("gde", fmt([[
	// TODO: remove debug Setenv
	gde.Setenv("./dev_env")
    ]], {})),

    -- fmt.Println
    s("pl", fmt([[
    fmt.Println(<vars>)
    ]], {
        vars = i(1, "any"),
    })),
    -- fmt.Printf
    s("pf", fmt([[
	fmt.Printf("<str>", <vars>)
    ]], {
        str = i(1, "str"),
        vars = i(2, "vars"),
    })),
    -- fmt.Sprintf
    s("spf", fmt([[
	fmt.Sprintf("<str>", <vars>)
    ]], {
        str = i(1, "str"),
        vars = i(2, "vars"),
    })),
    -- fmt.Errorf
    s("ef", fmt([[
	fmt.Errorf("<str>", <vars>)
    ]], {
        str = i(1, "str"),
        vars = i(2, "err"),
    })),

    -- error check
    s("ec", fmt([[
    if <err> != nil {
        return <returns>
    }
    ]], {
        err = i(1, "err"),
        returns = d(2, function(args)
            local result = {}
            local rets = xts.get_func_return_types()
            local err_name = args[1][1]
            local nIdx = 0
            for idx, ret in ipairs(rets) do
                local val = t("nil")
                if ret == "error" then
                    nIdx = nIdx + 1
                    val = c(nIdx, {
                        t(err_name),
                        sn(nil, fmt([[
                            fmt.Errorf("<msg>: %w", <err>)
                            ]], {
                            msg = i(1, "error occurred"),
                            err = t(err_name),
                        }))
                    })
                elseif xgo.zero_values[ret] ~= nil then
                    val = t(xgo.zero_values[ret])
                end
                table.insert(result, val)
                if idx ~= #rets then
                    table.insert(result, t(", "))
                end
            end
            return sn(nil, result)
        end, { 1 }),
    })),

    -- gracefully shutdown services
    s("gss", fmt([[
    ch := make(chan os.Signal, 1)
    signal.Notify(ch, os.Interrupt, syscall.SIGTERM)
    <<-ch
    // gracefully shutdown services: http server, cron ...
    <todo>
    ]], {
        todo = i(1),
    })),

    s("testmain", fmt([[
import (
	"os"
	"testing"
)

func TestMain(m *testing.M) {
    <sth>
	os.Exit(m.Run())
}
    ]], {
        sth = i(1),
    })),
}

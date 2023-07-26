local ls = require('luasnip')
local s = ls.s
local i = ls.i
local t = ls.t
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node
local fmt = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep
local xutils = require('x.utils')
local xts = require('x.treesitter')

local go_zero_values = {
    int = '0',
    bool = 'false',
    string = [[""]],
}

xutils.set_same_value_entries(go_zero_values, 'int',
    'int8', 'int16', 'int32', 'int64',
    'uint', 'uint8', 'uint16', 'uint32', 'uint64',
    'float32', 'float64')

return {
    s('pkd', t('import _ "github.com/lib/pq"')),
    s('pkl', t('import kitlog "github.com/theplant/appkit/log"')),
    s('pkh', t('import h "github.com/theplant/htmlgo"')),
    s('pkv', t('import . "github.com/qor5/ui/vuetify"')),
    s('pkvx', t('import vx "github.com/qor5/ui/vuetifyx"')),

    -- cases test
    s('ct', fmt([[
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
        func = i(1, 'func'),
        expect = i(2, 'expect'),
        expect_type = i(3, 'type'),
        expect_rep = rep(2),
        func_rep = rep(1),
    })),

    -- debug print
    s('dp', fmt([[
	fmt.Println("#########################################start")
	testingutils.PrintlnJson(<args>)
	fmt.Println("#########################################end")
    ]], {
        args = i(1),
    })),

    -- http handler
    s('hh', fmt([[
	func(w http.ResponseWriter, r *http.Request) {
        <body>
	}
    ]], {
        body = i(1, 'body'),
    })),

    -- set debug env
    s('gde', fmt([[
	// TODO: remove debug Setenv
	gde.Setenv("./dev_env")
    ]], {})),

    -- fmt.Println
    s('pl', fmt([[
    fmt.Println(<vars>)
    ]], {
        vars = i(1, 'any'),
    })),
    -- fmt.Printf
    s('pf', fmt([[
	fmt.Printf("<str>", <vars>)
    ]], {
        str = i(1, 'str'),
        vars = i(2, 'vars'),
    })),
    -- fmt.Sprintf
    s('spf', fmt([[
	fmt.Sprintf("<str>", <vars>)
    ]], {
        str = i(1, 'str'),
        vars = i(2, 'vars'),
    })),
    -- fmt.Errorf
    s('ef', fmt([[
	fmt.Errorf("<str>", <vars>)
    ]], {
        str = i(1, 'str'),
        vars = i(2, 'err'),
    })),

    -- error check
    s('ec', fmt([[
    if <err> != nil {
        return <returns>
    }
    ]], {
        err = i(1, 'err'),
        returns = d(2, function(args)
            local err_name = args[1][1]
            if err_name == '' then
                return
            end
            local result = {}
            local rets = xts.go_return_types()
            local info = {
                index = 0,
                err_name = err_name,
            }
            for idx, ret in ipairs(rets) do
                local val = t('nil')
                if ret == 'error' then
                    info.index = info.index + 1
                    val = c(info.index, {
                        t(info.err_name),
                        sn(nil, fmt([[
                            fmt.Errorf("<msg>: %w", <err>)
                            ]], {
                            msg = i(1, 'error occurred'),
                            err = t(info.err_name),
                        }))
                    })
                elseif go_zero_values[ret] ~= nil then
                    val = t(go_zero_values[ret])
                end
                table.insert(result, val)
                if idx ~= #rets then
                    table.insert(result, t(', '))
                end
            end
            return sn(nil, result)
        end, { 1 }),
    })),

    -- gracefully shutdown services
    s('gss', fmt([[
    ch := make(chan os.Signal, 1)
    signal.Notify(ch, os.Interrupt, syscall.SIGTERM)
    <<-ch
    // gracefully shutdown services: http server, cron ...
    <todo>
    ]], {
        todo = i(1),
    })),

    -- print memory usage
    s('pm', fmt([[
	go func() {
		ticker := time.NewTicker(time.Second)
		for range ticker.C {
			var m runtime.MemStats
			runtime.ReadMemStats(&m)
			fmt.Println("#########################################")
			fmt.Printf("Alloc = %v MiB", m.Alloc/1024/1024)
			fmt.Printf("\tTotalAlloc = %v MiB", m.TotalAlloc/1024/1024)
			fmt.Printf("\tSys = %v MiB", m.Sys/1024/1024)
			fmt.Printf("\tNumGC = %v\n", m.NumGC)
			fmt.Println("#########################################")
		}
	}()
    ]], {}))
}

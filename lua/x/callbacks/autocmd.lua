local M = {}

function M.set_filetype_func(ft)
    return function()
        vim.bo.filetype = ft
    end
end

function M.set_tab_to_n_spaces_func(n, expandtab)
    if expandtab == nil then
        expandtab = true
    end
    return function()
        vim.bo.tabstop = n
        vim.bo.softtabstop = n
        vim.bo.shiftwidth = n
        vim.bo.expandtab = expandtab
    end
end

function M.off_syntax()
    vim.cmd('ownsyntax off')
end

function M.restore_cursor()
    require('x.restore_cursor').restore_cursor()
end

function M.set_statusline_func(v)
    return function()
        vim.wo.statusline = v
    end
end

function M.set_commentstring_func(v)
    return function()
        vim.bo.commentstring = v
    end
end

function M.format_go()
    require('x.go').goimports(1000)
end

function M.new_go_file_tpl()
    require('x.go').new_file_tpl()
end

function M.new_pnvim_lua_file()
    require('x.lua').new_pnvim_file()
end

return M

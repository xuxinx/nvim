local M = {}

M.set_filetype_func = function(ft)
    return function()
        vim.bo.filetype = ft
    end
end

M.set_tab_to_n_spaces_func = function(n, expandtab)
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

M.off_syntax = function()
    vim.cmd("ownsyntax off")
end

M.restore_cursor = function()
    require("x.restore_cursor").restore_cursor()
end

M.set_statusline_func = function(v)
    return function()
        vim.wo.statusline = v
    end
end

M.set_commentstring_func = function(v)
    return function()
        vim.bo.commentstring = v
    end
end

M.format_go = function()
    require("x.go").goimports(1000)
end

M.new_go_file_tpl = function()
    require("x.go").new_file_tpl()
end

M.auto_save_session = function()
    if vim.fn.expand("%") == ".git/COMMIT_EDITMSG" then
        return
    end
    require("x.session").save_session()
end

return M

local M = {}

function M.curr_dir()
    return vim.fn.fnamemodify(vim.fn.expand('%:p:h'), ':t')
end

function M.base_cwd()
    return vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
end

function M.curr_file_path()
    return vim.fn.expand('%:p:~:.')
end

-- http://www.lua.org/pil/11.5.html
function M.set(list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set
end

M.set_same_value_entries = function (t, tk, ...)
    for _, k in pairs({...}) do
        t[k] = t[tk]
    end
end

return M

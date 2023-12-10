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

M.set_same_value_entries = function(t, tk, ...)
    for _, k in pairs({ ... }) do
        t[k] = t[tk]
    end
end

M.merge_arrays = function(...)
    local r = {}
    for _, arr in ipairs({ ... }) do
        for _, v in ipairs(arr) do
            table.insert(r, v)
        end
    end
    return r
end

M.trim_prefix = function(str, prefix)
    return (str:sub(0, #prefix) == prefix) and str:sub(#prefix + 1) or str
end

M.get_file_extension = function(fname)
    return fname:match("^.+%.(.+)$")
end

return M

local M = {}

-- # file and path

M.get_curr_dir_name = function()
    return vim.fn.fnamemodify(vim.fn.expand("%:p:h"), ":t")
end

M.get_base_cwd_name = function()
    return vim.fn.substitute(vim.fn.getcwd(), "^.*/", "", "")
end

M.get_curr_file_absolute_path = function()
    return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
end

M.get_curr_file_relative_path = function()
    return vim.fn.expand("%:p:~:.")
end

M.get_curr_file_name = function()
    return vim.fs.basename(vim.api.nvim_buf_get_name(0))
end

M.get_filename_extension = function(fname)
    return fname:match("^.+%.(.+)$")
end

M.remove_filename_extension = function(fname)
    return fname:match("(.+)%..+")
end

M.join_path = function(...)
    local raw
    for i, path in ipairs({ ... }) do
        if i == 1 then
            raw = path
        else
            raw = raw .. "/" .. path
        end
    end
    return vim.fn.resolve(raw)
end

-- # table

-- http://www.lua.org/pil/11.5.html
M.list_to_set = function(list)
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

-- # string

M.trim_prefix = function(str, prefix)
    return (str:sub(0, #prefix) == prefix) and str:sub(#prefix + 1) or str
end

M.string_to_line_array = function(str)
    local a = {}
    local lines = string.gmatch(str, "[^\r\n]+")
    for line in lines do
        table.insert(a, line)
    end
    return a
end

-- anyKindOfString
M.lower_camel_string = function(str)
    str = str:lower()
    return str:gsub("_(.)", string.upper)
end

-- AnyKindOfString
M.camel_string = function(str)
    str = M.lower_camel_string(str)
    return str:gsub("^%w", string.upper)
end

-- any_kind_of_string
M.snake_string = function(str)
    return str:gsub("([A-Z0-9]+)([A-Z])", "%1_%2"):gsub("([a-z][0-9]*)([A-Z]+)", "%1_%2"):lower()
end

-- # lua api

M.feedkeys = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), mode or "m", false)
end


return M

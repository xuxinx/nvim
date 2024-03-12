local M = {}

M.setup = function()
    require("nvim-treesitter.configs").setup {
        ensure_installed = "all",
        ignore_install = { "sql" },
        highlight = {
            enable = true,
            disable = function(lang, bufnr)
                local filepath = vim.api.nvim_buf_get_name(bufnr)
                local stats = vim.loop.fs_stat(filepath)
                if stats and stats.size / vim.api.nvim_buf_line_count(bufnr) > 1024 then
                    return true
                end
                return false
            end,
            additional_vim_regex_highlighting = false,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "select around function" },
                    ["if"] = { query = "@function.inner", desc = "select inside function" },
                    ["ao"] = { query = "@class.outer", desc = "select around class" },
                    ["io"] = { query = "@class.inner", desc = "select inside class" },
                    ["al"] = { query = "@loop.outer", desc = "select around loop" },
                    ["il"] = { query = "@loop.inner", desc = "select inside loop" },
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]f"] = { query = "@function.outer", desc = "go to next function" },
                    ["]o"] = { query = "@class.outer", desc = "go to next class" },
                },
                goto_previous_start = {
                    ["[f"] = { query = "@function.outer", desc = "go to previous function" },
                    ["[o"] = { query = "@class.outer", desc = "go to previous class" },
                },
            },
        },
    }
end

local default_func_node_types = {
        function_declaration = true,
        method_declaration = true,
        func_literal = true,
    }

local get_func_node = function(fnode_types)
    fnode_types = fnode_types or default_func_node_types
    local fnode = vim.treesitter.get_node()
    while fnode ~= nil do
        if fnode_types[fnode:type()] then
            return fnode
        end
        fnode = fnode:parent()
    end
    return nil
end

M.get_func_return_types = function(fnode_types)
    local fnode = get_func_node(fnode_types)
    if not fnode then
        vim.notify("not inside of a function", vim.log.levels.WARN)
        return {}
    end

    local query = vim.treesitter.query.parse(
        "go",
        [[
      [
        (method_declaration result: (_) @type)
        (function_declaration result: (_) @type)
        (func_literal result: (_) @type)
      ]
    ]]
    )

    for _, cnode in query:iter_captures(fnode, 0) do
        if cnode:type() == "parameter_list" then
            local result = {}
            local count = cnode:named_child_count()
            for idx = 0, count - 1 do
                local matching_node = cnode:named_child(idx)
                local type_node = matching_node:field("type")[1]
                table.insert(result, vim.treesitter.get_node_text(type_node, 0))
            end
            return result
        elseif cnode:type() == "type_identifier" then
            return { vim.treesitter.get_node_text(cnode, 0) }
        end
    end

    vim.notify("cannot recognize return types", vim.log.levels.WARN)
    return {}
end

M.get_func_name = function(fnode_types)
    local fnode = get_func_node(fnode_types)
    if not fnode then
        vim.notify("not inside of a function", vim.log.levels.WARN)
        return {}
    end
    return vim.treesitter.get_node_text(fnode:field("name")[1], 0)
end

return M

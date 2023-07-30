local locals = require('nvim-treesitter.locals')
local utils = require('nvim-treesitter.ts_utils')

local M = {}

M.setup = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',
        ignore_install = { 'sql' },
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
                    ['af'] = { query = '@function.outer', desc = 'select around function' },
                    ['if'] = { query = '@function.inner', desc = 'select inside function' },
                    ['ao'] = { query = '@class.outer', desc = 'select around class' },
                    ['io'] = { query = '@class.inner', desc = 'select inside class' },
                    ['al'] = { query = '@loop.outer', desc = 'select around loop' },
                    ['il'] = { query = '@loop.inner', desc = 'select inside loop' },
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']f'] = { query = '@function.outer', desc = 'go to next function' },
                    [']o'] = { query = '@class.outer', desc = 'go to next class' },
                },
                goto_previous_start = {
                    ['[f'] = { query = '@function.outer', desc = 'go to previous function' },
                    ['[o'] = { query = '@class.outer', desc = 'go to previous class' },
                },
            },
        },
    }
end

local function_node_types = {
    function_declaration = true,
    method_declaration = true,
    func_literal = true,
}

M.go_return_types = function()
    local cursor_node = assert(utils.get_node_at_cursor())
    local scope = locals.get_scope_tree(cursor_node, 0)
    local function_node
    for _, v in ipairs(scope) do
        if function_node_types[v:type()] then
            function_node = v
            break
        end
    end

    if not function_node then
        print('not inside of a function')
        return {}
    end

    local query = vim.treesitter.query.parse(
        'go',
        [[
      [
        (method_declaration result: (_) @id)
        (function_declaration result: (_) @id)
        (func_literal result: (_) @id)
      ]
    ]]
    )

    for _, node in query:iter_captures(function_node, 0) do
        if node:type() == 'parameter_list' then
            local result = {}
            local count = node:named_child_count()
            for idx = 0, count - 1 do
                local matching_node = node:named_child(idx)
                local type_node = matching_node:field('type')[1]
                table.insert(result, vim.treesitter.get_node_text(type_node, 0))
            end

            return result
        elseif node:type() == 'type_identifier' then
            return { vim.treesitter.get_node_text(node, 0) }
        end
    end

    print('cannot recognize return types')
    return {}
end

return M

local utils = require("x.utils")

local M = {}

local list_node_types = {
    parameter_list = true,
    argument_list = true,
    parameters = true,
    arguments = true,
    expression_list = true,
    variable_list = true,
    literal_value = true,
    table_constructor = true,
}

local get_item_node_and_its_list_node = function(node)
    local child = node
    local parent = child:parent()
    while list_node_types[parent:type()] ~= true do
        child = parent
        parent = child:parent()
        if parent == nil then
            return nil, nil
        end
    end
    return child, parent
end

M.swap_list_items = function(target_index)
    local cursor_node = vim.treesitter.get_node()
    local cursor_item_node, list_node = get_item_node_and_its_list_node(cursor_node)
    if list_node == nil then
        vim.notify("not a list item node", vim.log.levels.WARN)
        return
    end
    cursor_item_node = assert(cursor_item_node)
    if target_index > list_node:named_child_count() then
        vim.notify("target index exceed", vim.log.levels.WARN)
        return
    end

    local count = list_node:child_count()

    local target_node
    target_index = target_index - 1
    local target_text
    for i = 0, count - 1 do
        local inode = list_node:child(i)
        if inode:named() ~= true then
            target_index = target_index + 1
        end
        if i == target_index then
            target_node = inode
            target_text = vim.treesitter.get_node_text(inode, 0)
            break
        end
    end

    local cursor_index
    local cursor_text = vim.treesitter.get_node_text(cursor_item_node, 0)
    for i = 0, count - 1 do
        local inode = list_node:child(i)
        if inode:id() == cursor_item_node:id() then
            cursor_index = i
        end
    end

    local tsrow, tscol, _ = target_node:start()
    local terow, tecol, _ = target_node:end_()
    vim.api.nvim_buf_set_text(0, tsrow, tscol, terow, tecol, utils.string_to_line_array(cursor_text))

    cursor_item_node = list_node:child(cursor_index)
    local csrow, cscol, _ = cursor_item_node:start()
    local cerow, cecol, _ = cursor_item_node:end_()
    vim.api.nvim_buf_set_text(0, csrow, cscol, cerow, cecol, utils.string_to_line_array(target_text))
end

return M

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

local get_list_node = function(node)
    while list_node_types[node:type()] ~= true do
        node = node:parent()
        if node == nil then
            return nil
        end
    end
    return node
end

M.toggle_list_format = function()
    local cursor_node = vim.treesitter.get_node()
    local list_node = get_list_node(cursor_node)
    if list_node == nil then
        vim.notify("not a list item node", vim.log.levels.WARN)
        return
    end

    local srow, scol, _ = list_node:start()
    local erow, ecol, _ = list_node:end_()

    local count = list_node:named_child_count()
    local item_texts = {}
    local to_multi_lines = false
    local prev_row = srow
    for i = 0, count - 1 do
        local inode = list_node:named_child(i)
        local row, _, _ = inode:start()
        if row == prev_row then
            to_multi_lines = true
        end
        table.insert(item_texts, vim.treesitter.get_node_text(inode, 0))
    end

    vim.api.nvim_buf_set_text(0, srow, scol + 1, erow, ecol - 1, { "" })
    vim.api.nvim_win_set_cursor(0, { srow + 1, scol + 1 })
    local sep = ","
    for i, item_text in ipairs(item_texts) do
        local lines = {}
        if to_multi_lines == true then
            table.insert(lines, "")
        end
        local text = item_text
        if i ~= #item_texts then
            text = text .. sep
            if to_multi_lines ~= true then
                text = text .. " "
            end
        end
        table.insert(lines, text)
        vim.api.nvim_put(lines, "c", false, true)
    end
    if to_multi_lines then
        vim.api.nvim_put({ sep, "" }, "c", false, true)
    end

    -- indent lines
    srow, scol, _ = list_node:start()
    erow, _, _ = list_node:end_()
    vim.api.nvim_win_set_cursor(0, { srow + 1, 0 })
    local js = ""
    if erow ~= srow then
        js = (erow - srow) .. "j"
    end
    vim.cmd("execute 'normal V" .. js .. "=='")

    -- restore cusror position
    -- TODO: original node position
    srow, scol, _ = list_node:start()
    vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
end

return M

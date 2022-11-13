local M = {}

local function get_curr_buf_names(tab_count)
    local buf_names = {}
    for tab_num = 1, tab_count do
        local win_num = vim.fn.tabpagewinnr(tab_num)
        local buf_list = vim.fn.tabpagebuflist(tab_num)
        local buf_num = buf_list[win_num]
        local buf_name = vim.fn.bufname(buf_num)
        if (buf_name ~= '') then
            buf_name = vim.fn.fnamemodify(buf_name, ':~:.')
        end
        local base_name = vim.fn.fnamemodify(buf_name, ':t')
        buf_names[tab_num] = {}
        buf_names[tab_num]['fn'] = buf_name
        buf_names[tab_num]['bn'] = base_name
        buf_names[tab_num]['sn'] = base_name
    end

    local bn_group = {}
    for tab_num, name in ipairs(buf_names) do
        local bn = name['bn']
        if (bn_group[bn] == nil) then
            bn_group[bn] = {}
        end
        table.insert(bn_group[bn], tab_num)
    end

    for _, tab_nums in pairs(bn_group) do
        if (#tab_nums > 1) then
            for _, tab_num in ipairs(tab_nums) do
                buf_names[tab_num]['sn'] = buf_names[tab_num]['fn']
            end
        end
    end

    return buf_names
end

function M.tabline()
    local s = ''
    local tab_count = vim.fn.tabpagenr('$')
    local buf_names = get_curr_buf_names(tab_count)
    for tab_num = 1, tab_count do
        local win_num = vim.fn.tabpagewinnr(tab_num)
        local buf_list = vim.fn.tabpagebuflist(tab_num)
        local buf_num = buf_list[win_num]
        -- FIXME: different tab different lcd
        local buf_name = buf_names[tab_num]['sn']

        -- FIXME: to get all hidden buffers in the tab
        local bufmodified = false
        for _, b in ipairs(buf_list) do
            if (vim.fn.getbufvar(b, '&modified') == 1) then
                bufmodified = true
            end
        end

        local fname = ''
        local buftype = vim.fn.getbufvar(buf_num, '&buftype')
        if (buftype == '') then
            if (buf_name ~= '') then
                fname = buf_name
            else
                fname = '[No Name]'
            end
        elseif (buftype == 'quickfix') then
            fname = '[Quickfix List]'
        elseif buftype == 'help' then
            fname = '[Help]'
        else
            fname = '[' .. buf_name .. ']'
        end

        if tab_num == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end

        -- set the tab page number (for mouse clicks)
        s = s .. '%' .. tab_num .. 'T'

        s = s .. ' [' .. tab_num .. '] ' .. fname .. ' '
        if bufmodified then
            s = s .. '+ '
        end
    end

    -- after the last tab fill with TabLineFill and reset tab page nr
    s = s .. '%#TabLineFill#%T'

    -- right-align the label to close the current tab page
    if tab_count > 1 then
        s = s .. '%=%#TabLine#%999XX'
    end

    return s
end

return M

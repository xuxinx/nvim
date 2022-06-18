local M = {}

local function getCurrBufNames(tabCount)
    local bufNames = {}
    for tabNum=1,tabCount do
        local winNum = vim.fn.tabpagewinnr(tabNum)
        local bufList = vim.fn.tabpagebuflist(tabNum)
        local bufNum = bufList[winNum]
        local bufName = vim.fn.bufname(bufNum)
        if (bufName ~= '') then
            bufName = vim.fn.fnamemodify(bufName, ':~:.')
        end
        local baseName = vim.fn.fnamemodify(bufName, ':t')
        bufNames[tabNum] = {}
        bufNames[tabNum]['fn'] = bufName
        bufNames[tabNum]['bn'] = baseName
        bufNames[tabNum]['sn'] = baseName
    end

    local bnGroup = {}
    for tabNum, name in ipairs(bufNames) do
        local bn = name['bn']
        if (bnGroup[bn] == nil) then
            bnGroup[bn] = {}
        end
        table.insert(bnGroup[bn], tabNum)
    end

    for _, tabNums in pairs(bnGroup) do
        if (#tabNums > 1) then
            for _, tabNum in ipairs(tabNums) do
                bufNames[tabNum]['sn'] = bufNames[tabNum]['fn']
            end
        end
    end

    return bufNames
end

function M.tabline()
    local s = ''
    local tabCount = vim.fn.tabpagenr('$')
    local bufNames = getCurrBufNames(tabCount)
    for tabNum=1,tabCount do
        local winNum = vim.fn.tabpagewinnr(tabNum)
        local bufList = vim.fn.tabpagebuflist(tabNum)
        local bufNum = bufList[winNum]
        -- FIXME: different tab different lcd
        local bufName = bufNames[tabNum]['sn']

        -- FIXME: to get all hidden buffers in the tab
        local bufmodified = false
        for _, b in ipairs(bufList) do
            if (vim.fn.getbufvar(b, '&modified') == 1) then
                bufmodified = true
            end
        end

        local fname = ''
        local buftype = vim.fn.getbufvar(bufNum, '&buftype')
        if (buftype == '') then
            if (bufName ~= '') then
                fname = bufName
            else
                fname = '[No Name]'
            end
        elseif (buftype == 'quickfix') then
            fname = '[Quickfix List]'
        elseif buftype == 'help' then
            fname = '[Help]'
        else
            fname = '[' .. bufName .. ']'
        end

        if tabNum == vim.fn.tabpagenr() then
            s = s .. '%#TabLineSel#'
        else
            s = s .. '%#TabLine#'
        end

        -- set the tab page number (for mouse clicks)
        s = s .. '%' .. tabNum .. 'T'

        s = s .. ' [' .. tabNum .. '] ' .. fname .. ' '
        if bufmodified then
            s = s .. '+ '
        end
    end

    -- after the last tab fill with TabLineFill and reset tab page nr
    s = s .. '%#TabLineFill#%T'

    -- right-align the label to close the current tab page
    if tabCount > 1 then
        s = s .. '%=%#TabLine#%999XX'
    end

    return s
end

return M

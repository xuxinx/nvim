local M = {}

function M.search_copied()
    local reg_txt = vim.fn.getreg('"')

    for _, v in ipairs({ '\\', ']', '{', '}', '#' }) do
        reg_txt = string.gsub(reg_txt, v, '\\' .. v)
    end
    -- lua special characters
    for _, v in ipairs({ '(', ')', '[', '.', '*', '+', '?', '^', '$', '%' }) do
        reg_txt = string.gsub(reg_txt, '%' .. v, '\\' .. v)
    end
    reg_txt = string.gsub(reg_txt, '\'', '\\x27')
    return ':grep! \'' .. reg_txt .. '\' .'
end

return M

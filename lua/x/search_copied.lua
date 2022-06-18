local M = {}

function M.searchCopied()
    local regTxt = vim.fn.getreg('"')

    for _, v in ipairs{'\\', ']', '{', '}', '#'} do
        regTxt = string.gsub(regTxt, v, '\\' .. v)
    end
    -- lua special characters
    for _, v in ipairs{'(', ')', '[', '.', '*', '+', '?', '^', '$', '%'} do
        regTxt = string.gsub(regTxt, '%' .. v, '\\' .. v)
    end
    regTxt = string.gsub(regTxt, '\'', '\\x27')
    return ':grep! \'' .. regTxt .. '\' .'
end

return M

local M = {}

M.toggle_todo = function()
    local line = vim.api.nvim_get_current_line()
    if line:find("^%s*- %[ ]") then
        local new = line:gsub("^(%s*- )%[ ]", "%1[x]")
        vim.api.nvim_set_current_line(new)
    elseif line:find("^%s*- %[x]") then
        local new = line:gsub("^(%s*- )%[x]", "%1[ ]")
        vim.api.nvim_set_current_line(new)
    end
end

return M

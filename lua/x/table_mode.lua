local M = {}

M.init = function()
    vim.g.table_mode_corner = "|"
    vim.g.table_mode_disable_mappings = true
    vim.g.table_mode_disable_tableize_mappings = true
end

local is_enabled = function()
    local ks = vim.api.nvim_buf_get_keymap(0, "i")
    for _, v in pairs(ks) do
        if v.lhs == "|" then
            return true
        end
    end
    return false
end

M.toggle_table_mode = function()
    if is_enabled() == true then
        vim.cmd("TableModeDisable")
        vim.keymap.del("i", "|", { buffer = true })
    else
        vim.cmd("TableModeEnable")
        vim.keymap.set("i", "|", "<Plug>(table-mode-tableize)", { buffer = true, desc = "table-mode tableize" })
    end
end

return M

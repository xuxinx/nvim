local M = {}

M.setup = function()
    require("gitsigns").setup({
        signs = {
            add = { text = '+' },
            change = { text = '│' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
            untracked = { text = '┆' },
        },
        attach_to_untracked = true,
    })
end

M.statusline_branch_name = function(max_length, prefix)
    local v = vim.b.gitsigns_head
    if v == nil then
        return ""
    end
    if max_length ~= nil and #v > max_length then
        v = v:sub(1, max_length - 3) .. "..."
    end
    return prefix .. v
end

return M

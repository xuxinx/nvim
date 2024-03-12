local M = {}

M.setup = function()
    require("oil").setup({
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        use_default_keymaps = false,
        view_options = {
            show_hidden = false,
            -- use wildignore as ignore rule
            is_hidden_file = function(name, bufnr)
                local patterns = vim.split(vim.o.wildignore, ",")
                table.insert(patterns, "..")
                for _, pattern in ipairs(patterns) do
                    -- convert to lua regex
                    pattern = pattern:gsub("([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1"):gsub("%*", ".*"):gsub("%?", ".")
                    if string.match(name, "^" .. pattern .. "$") then
                        return true
                    end
                end
                return false
            end,
        },
    })
end

return M

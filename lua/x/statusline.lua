local utils = require("x.utils")

local M = {}
M.helpers = {}

M.helpers.curr_file_path = function()
    local path = utils.get_curr_file_relative_path()
    if (path == "") then
        return "[No Name]"
    end
    return path
end

local lsp_diagnostic_info = {}

local function update_lsp_diagnostic_info()
    local error_count = 0
    local warn_count = 0
    local info_count = 0
    local hint_count = 0
    local info = vim.diagnostic.get(0)
    for _, v in ipairs(info) do
        if v.severity == vim.diagnostic.severity.ERROR then
            error_count = error_count + 1
        elseif v.severity == vim.diagnostic.severity.WARN then
            warn_count = warn_count + 1
        elseif v.severity == vim.diagnostic.severity.INFO then
            info_count = info_count + 1
        elseif v.severity == vim.diagnostic.severity.HINT then
            hint_count = hint_count + 1
        else
            vim.notify("unknown diagnostic severity: " .. v.severity, vim.log.levels.WARN)
        end
    end

    local s = ""
    if error_count > 0 then
        s = s .. "E" .. error_count
    end
    if warn_count > 0 then
        s = s .. "W" .. warn_count
    end
    if info_count > 0 then
        s = s .. "I" .. info_count
    end
    if hint_count > 0 then
        s = s .. "H" .. hint_count
    end

    lsp_diagnostic_info[vim.api.nvim_buf_get_name(0)] = s
end

vim.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged" }, {
    desc = "update diagnostic info for statusline",
    pattern = { "*" },
    callback = update_lsp_diagnostic_info,
})

M.helpers.get_lsp_diagnostic_info = function()
    local v = lsp_diagnostic_info[vim.api.nvim_buf_get_name(0)]
    if v == nil then
        return ""
    end
    return v
end

M.statusline = function()
    local s = ""

    -- base cwd
    s = s .. utils.get_base_cwd_name() .. ":"

    -- filepath
    s = s .. [[ %{v:lua.require("x.statusline").helpers.curr_file_path()}]]

    -- modified readonly help preview
    s = s .. "%m%r%h%w"

    -- git status
    s = s .. [[ %{get(b:,"gitsigns_status","")}]]

    -- lsp diagnostics
    s = s .. [[ %{v:lua.require("x.statusline").helpers.get_lsp_diagnostic_info()}]]

    -- spacer
    s = s .. "%="

    -- row col
    s = s .. "%l/%L,%c"

    -- file format
    s = s .. " | %{&fileformat}"

    -- file encoding
    s = s .. [[ | %{&fileencoding ? &fileencoding : &encoding}]]

    -- filetype
    if vim.bo.filetype ~= "" then
        s = s .. [[ | %{&filetype}]]
    end

    -- git branch
    s = s .. [[ %{v:lua.require("x.gitsigns").statusline_branch_name(45, "| ")}]]

    return s
end

return M

local utils = require("x.utils")

local M = {}

local PCFG_default_str = [[
{
    telescope = {
        ignore_dirs = {},
        ignore_file_extensions = {},
        ignore_files = {},
        ignore_free_patterns = {},
    },
    init = function()
    end,
    after = function()
    end,
}
]]
local PCFG_default = load("return " .. PCFG_default_str)()

local store_dir = utils.join_path(vim.fn.stdpath("data"), "project_configs") .. "/"
vim.fn.mkdir(store_dir, "p")

local function fname()
    return string.gsub(vim.fn.getcwd() .. ".lua", "/", "%%")
end

M.edit = function()
    local f = store_dir .. fname()
    if vim.fn.filereadable(f) ~= 1 then
        local wf = assert(io.open(f, "w"))
        wf:write("PCFG = " .. PCFG_default_str)
        wf:close()
    end
    vim.cmd("e " .. vim.fn.fnameescape(f))
end

local init = function()
    local f = store_dir .. fname()
    if vim.fn.filereadable(f) == 1 then
        vim.cmd("luafile " .. vim.fn.fnameescape(f))
    end
    PCFG = vim.tbl_deep_extend("force", PCFG_default, PCFG or {})
    if PCFG.init ~= nil then
        PCFG.init()
    end
end

local after = function ()
    if PCFG.after ~= nil then
        PCFG.after()
    end
end

init()

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("x_augroup_project_config", {clear = true}),
    pattern = "*",
    desc = "execute project_config.after",
    callback = function()
        after()
    end,
})

return M

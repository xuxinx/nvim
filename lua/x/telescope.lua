local utils = require("x.utils")
local previewers = require("telescope.previewers")

local M = {}

local ignore_dirs = utils.merge_arrays({
}, PCFG.telescope.ignore_dirs)
local ignore_file_extensions = utils.merge_arrays({
}, PCFG.telescope.ignore_file_extensions)
local ignore_files = utils.merge_arrays({
}, PCFG.telescope.ignore_files)
local ignore_free_patterns = utils.merge_arrays({
}, PCFG.telescope.ignore_free_patterns)

local file_ignore_patterns = {}

for _, v in pairs(ignore_dirs) do
    local p = v:gsub("([.-])", "%%%1") .. "/"
    table.insert(file_ignore_patterns, "^" .. p)
    table.insert(file_ignore_patterns, "/" .. p)
end
for _, v in pairs(ignore_file_extensions) do
    local p = v:gsub("([.-])", "%%%1") .. "$"
    table.insert(file_ignore_patterns, p)
end
for _, v in pairs(ignore_files) do
    local p = v:gsub("([.-])", "%%%1") .. "$"
    table.insert(file_ignore_patterns, "^" .. p)
    table.insert(file_ignore_patterns, "/" .. p)
end
for _, v in pairs(ignore_free_patterns) do
    table.insert(file_ignore_patterns, v)
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    filepath = vim.fn.expand(filepath)
    local stats = vim.loop.fs_stat(filepath)
    -- FIXME: vim.api.nvim_buf_line_count(bufnr) always 1 here
    if stats and stats.size > 100 * 1024 then
        opts.use_ft_detect = false
    end
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

M.setup = function()
    require("telescope").setup {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--hidden",
            },
            file_ignore_patterns = file_ignore_patterns,
            buffer_previewer_maker = new_maker,
        },
        pickers = {
            buffers = {
                ignore_current_buffer = false,
                sort_mru = true,
                sort_lastused = true,
            },
        },
    }

    require("telescope").load_extension("fzf")
end

M.find_files = function (opts)
    require("telescope.builtin").find_files(vim.tbl_deep_extend("force", {
        find_command = {
            "rg",
            "--files",
            "--hidden",
        },
    }, opts or {}))
end

return M

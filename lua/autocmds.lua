local acs = {
    -- # indentations
    {
        "FileType",
        pattern = { "yaml", "proto", "c", "cpp", "markdown" },
        desc = "set tab to 2 spaces",
        callback = function()
            vim.bo.tabstop = 2
            vim.bo.softtabstop = 2
            vim.bo.shiftwidth = 2
            vim.bo.expandtab = true
        end,
    },
    {
        "FileType",
        pattern = { "go" },
        desc = "set expandtab false",
        callback = function()
            vim.bo.expandtab = false
        end,
    },
    {
        "FileType",
        pattern = { "snippets" },
        desc = "set tab length = 8 spaces",
        callback = function()
            vim.bo.tabstop = 8
            vim.bo.softtabstop = 8
            vim.bo.shiftwidth = 8
            vim.bo.expandtab = false
        end,
    },

    -- # off syntax
    {
        { "BufNewFile", "BufWinEnter" },
        pattern = { "go.sum" },
        desc = "off syntax",
        callback = function()
            vim.cmd("ownsyntax off")
        end,
    },

    -- # restore cursor
    {
        { "BufReadPost" },
        pattern = "*",
        desc = "restore cursor",
        callback = function()
            require("x.restore_cursor").restore_cursor()
        end,
    },

    -- # statusline
    {
        { "BufWinEnter" },
        pattern = { "dap-scopes-*" },
        desc = "debug scopes",
        callback = function()
            vim.wo.statusline = "Scopes"
            vim.wo.wrap = false
        end,
    },
    {
        "FileType",
        pattern = "dap-repl",
        desc = "debug repl",
        callback = function()
            vim.wo.statusline = "REPL"
        end,
    },

    -- # commentary
    {
        { "BufNewFile", "BufRead" },
        pattern = { "*.mod", "*.work", "*.proto" },
        desc = "set comment string",
        callback = function()
            vim.bo.commentstring = "// %s"
        end,
    },
    {
        "FileType",
        pattern = { "http" },
        desc = "set comment string",
        callback = function()
            vim.bo.commentstring = "# %s"
        end,
    },

    {
        "BufWritePre",
        pattern = "*",
        desc = "auto format",
        callback = function(args)
            require("x.format").format(args.buf)
        end,
    },

    -- # go file template
    {
        { "BufNewFile", "BufReadPre" },
        pattern = "*.go",
        desc = "new go template",
        callback = function()
            require("x.go").new_file_tpl()
        end,
    },

    -- # session
    {
        "VimLeave",
        pattern = "*",
        desc = "auto save session",
        callback = function()
            if vim.fn.expand("%") == ".git/COMMIT_EDITMSG" then
                return
            end
            require("x.session").save_session()
        end,
    },

    -- # terminal
    {
        "TermOpen",
        pattern = "*",
        desc = "set terminal options",
        callback = function()
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
        end,
    },

    -- # oil
    {
        "User",
        pattern = "OilActionsPost",
        desc = "oil OilActionsPost",
        callback = function(args)
            require("x.oil").actions_post_callback(args)
        end,
    },

    -- # hide signcolumn
    {
        "BufWinEnter",
        pattern = "copilot-*",
        desc = "copilot chat",
        callback = function()
            vim.o.signcolumn = "no"
        end,
    },
}

local group = vim.api.nvim_create_augroup("x_augroup_autocmds", { clear = true })
for _, ac in ipairs(acs) do
    vim.api.nvim_create_autocmd(ac[1], {
        group = group,
        pattern = ac.pattern,
        desc = ac.desc,
        callback = ac.callback,
    })
end

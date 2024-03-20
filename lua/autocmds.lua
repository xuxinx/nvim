local group = vim.api.nvim_create_augroup("x_augroup_autocmds", { clear = true })
local cac = function(event, opts)
    opts.group = group
    vim.api.nvim_create_autocmd(event, opts)
end

-- # filetype
cac({ "BufNewFile", "BufRead" }, {
    pattern = { "*.gohtml" },
    desc = "set filetype to html",
    callback = function()
        vim.bo.filetype = "html"
    end
})

-- # indentations
cac("FileType", {
    pattern = { "yaml", "proto", "c", "cpp" },
    desc = "set tab to 2 spaces",
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
        vim.bo.expandtab = true
    end
})
cac("FileType", {
    pattern = { "snippets" },
    desc = "set tab length = 8 spaces",
    callback = function()
        vim.bo.tabstop = 8
        vim.bo.softtabstop = 8
        vim.bo.shiftwidth = 8
        vim.bo.expandtab = false
    end
})

-- # off syntax
cac({ "BufNewFile", "BufWinEnter" }, {
    pattern = { "go.sum" },
    desc = "off syntax",
    callback = function()
        vim.cmd("ownsyntax off")
    end
})

-- # restore cursor
cac({ "BufReadPost" }, {
    desc = "restore cursor",
    callback = require("x.restore_cursor").restore_cursor
})

-- # statusline
cac({ "BufWinEnter" }, {
    pattern = { "dap-scopes-*" },
    desc = "debug scopes",
    callback = function()
        vim.wo.statusline = "Scopes"
        vim.wo.wrap = false
    end
})
cac("FileType", {
    pattern = "dap-repl",
    desc = "debug repl",
    callback = function()
        vim.wo.statusline = "REPL"
    end
})

-- # commentary
cac({ "BufNewFile", "BufRead" }, {
    pattern = { "*.mod", "*.work" },
    desc = "set comment string",
    callback = function()
        vim.bo.commentstring = "// %s"
    end
})

-- # auto format
cac("BufWritePre", {
    pattern = "*.go",
    desc = "auto format go",
    callback = function()
        require("x.go").goimports(1000)
    end
})

-- # go file template
cac({ "BufNewFile", "BufReadPre" }, {
    pattern = "*.go",
    desc = "new go template",
    callback = require("x.go").new_file_tpl
})

-- # session
cac("VimLeave", {
    desc = "auto save session",
    callback = function()
        if vim.fn.expand("%") == ".git/COMMIT_EDITMSG" then
            return
        end
        require("x.session").save_session()
    end,
})

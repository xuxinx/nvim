local M = {}

local prettier_fts = { "javascript", "javascriptreact", "typescript", "typescriptreact",
    "vue", "css", "less", "scss", "html", "json", "graphql", "markdown", "yaml" }

M.setup = function()
    local formatters = {
        kulala = {
            command = "kulala-fmt",
            args = { "format", "$FILENAME" },
            stdin = false,
        },
    }

    local formatters_by_ft = {
        go = { "goimports", "gofmt", lsp_format = "never" },
        python = { "black" },
        http = { "kulala" },
    }
    for _, ft in ipairs(prettier_fts) do
        formatters_by_ft[ft] = { "prettier" }
    end

    require("conform").setup({
        notify_on_error = true,
        default_format_opts = {
            lsp_format = "fallback",
        },
        formatters = formatters,
        formatters_by_ft = formatters_by_ft,
    })
end

return M

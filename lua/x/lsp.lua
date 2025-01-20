local M = {}

local server_options = {
    lua_ls = function(opts)
        opts.settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                },
                format = {
                    defaultConfig = {
                        align_continuous_assign_statement = "false",
                        align_continuous_rect_table_field = "false",
                        align_array_table = "false",
                    },
                }
            },
        }
    end,
    gopls = function(opts)
        opts.settings = {
            gopls = {
                usePlaceholders = true,
            },
        }
    end,
    clangd = function(opts)
        opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    end,
    ts_ls = function() end,
    vuels = function() end,
    bashls = function(opts)
        opts.settings = {
            bashIde = {
                shellcheckArguments = "-e SC2086",
            }
        }
    end,
    rust_analyzer = function() end,
    pyright = function() end,
}

M.setup = function()
    local lspconfig = require("lspconfig")
    local cmplsp = require("cmp_nvim_lsp")
    local capabilities = cmplsp.default_capabilities()

    for server, optf in pairs(server_options) do
        local opts = {
            capabilities = capabilities,
        }

        optf(opts)

        lspconfig[server].setup(opts)
    end
end

return M

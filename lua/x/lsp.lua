-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({})
local lspconfig = require("lspconfig")
local cmplsp = require("cmp_nvim_lsp")
local capabilities = cmplsp.default_capabilities()

local M = {}

local server_options = {
    lua_ls = function(opts)
        opts.settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                }
            },
        }
    end,
    gopls = function(opts)
        opts.settings = {
            gopls = {
                analyses = {
                    unusedparams = false,
                },
                -- staticcheck = true,
                usePlaceholders = true,
            },
        }
    end,
    clangd = function(opts)
        opts.filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
    end,
    tsserver = function() end,
    vuels = function() end,
    bashls = function(opts)
        opts.settings = {
            bashIde = {
                shellcheckArguments = "-e SC2086",
            }
        }
    end,
}

M.setup = function()
    for server, optf in pairs(server_options) do
        local opts = {
            capabilities = capabilities,
        }

        optf(opts)

        lspconfig[server].setup(opts)
    end
end

return M

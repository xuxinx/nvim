local lspconfig = require'lspconfig'
local lsputil = require'lspconfig.util'
local cmplsp = require'cmp_nvim_lsp'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmplsp.update_capabilities(capabilities)

local serverOptions = {
    ['sumneko_lua'] = function (opts)
        opts.settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    end,

    ['gopls'] = function (opts)
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

    ['jdtls'] = function (opts)
        opts.root_dir = function ()
            return lsputil.root_pattern(".git")() or vim.fn.getcwd()
        end
    end,

    ['tsserver'] = function (opts) end,
}

for server, optf in pairs(serverOptions) do
    local opts = {
        capabilities = capabilities,
    }

    optf(opts)

    lspconfig[server].setup(opts)
end

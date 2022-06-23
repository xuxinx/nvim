local lspconfig = require'lspconfig'
local lspinstaller = require'nvim-lsp-installer'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspinstaller.setup{
    ensure_installed = {"sumneko_lua", "gopls", "tsserver", "jdtls"}
}

for _, server in ipairs(lspinstaller.get_installed_servers()) do
    local opts = {
        capabilities = capabilities,
    }

    if server.name == 'sumneko_lua' then
        opts.settings = {
            Lua = {
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
    elseif server.name == 'gopls' then
        opts.settings = {
            gopls = {
                analyses = {
                    unusedparams = false,
                },
                -- staticcheck = true,
                usePlaceholders = true,
            },
        }
    end

    lspconfig[server.name].setup(opts)
end

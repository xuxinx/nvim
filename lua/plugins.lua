local packer_bootstrap
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
        'git', 'clone',
        '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
end

vim.cmd([[
  augroup xPacker
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require'packer'.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-vinegar'
    use {
        'neovim/nvim-lspconfig',
        after = {
            'nvim-cmp',
        },
        config = function ()
            require'x.lsp'
        end
    }
    use {
        'williamboman/mason.nvim',
        config = function ()
            require'mason'.setup()
        end
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'rafamadriz/friendly-snippets',
        },
        config = function ()
            require'x.cmp'
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function ()
            require'x.treesitter'
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function ()
            require'x.telescope'
        end
    }
    use {
        'rktjmp/lush.nvim',
        config = function ()
            require'x.lush'
        end
    }
    use {
        'phaazon/hop.nvim',
        config = function ()
            require'hop'.setup()
        end
    }
    use 'tpope/vim-commentary'
    use {
        'jiangmiao/auto-pairs',
        config = function()
            require'x.auto_pairs'
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require'gitsigns'.setup()
        end
    }
    use 'majutsushi/tagbar'
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require'colorizer'.setup()
        end
    }
    use {
        'mfussenegger/nvim-dap',
        after = {
            'nvim-dap-ui',
        },
        config = function ()
            require'x.dap'
        end
    }
    use 'rcarriga/nvim-dap-ui'
    use {
        'github/copilot.vim',
        opt = true,
    }
    use 'othree/html5.vim'
    use {
        'dinhhuy258/vim-local-history',
        run = ':UpdateRemotePlugins',
        config = function ()
            require'x.local_history'
        end
    }
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end,
    }
    use 'prettier/vim-prettier'

    if packer_bootstrap then
        print('packer bootstrap')
        require'packer'.sync()
    end
end)

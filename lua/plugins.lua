local packer_bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-vinegar'
    use {
        'neovim/nvim-lspconfig',
        after = {
            'nvim-cmp',
        },
        config = function()
            require('x.lsp')
        end
    }
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'honza/vim-snippets',
        },
        config = function()
            require('x.cmp')
            require('x.luasnip')
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('x.treesitter').setup()
        end
    }
    use {
        'nvim-treesitter/playground',
        opt = true
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('x.telescope')
        end
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    }
    use {
        'phaazon/hop.nvim',
        config = function()
            require('hop').setup()
        end
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        'jiangmiao/auto-pairs',
        config = function()
            require('x.auto_pairs')
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }
    use 'majutsushi/tagbar'
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }
    use {
        'mfussenegger/nvim-dap',
        config = function()
            require('x.dap')
        end
    }
    use {
        'github/copilot.vim',
        opt = true,
    }
    use {
        'dinhhuy258/vim-local-history',
        run = ':UpdateRemotePlugins',
        config = function()
            require('x.local_history')
        end
    }
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkdp#util#install"]() end,
    }
    use 'prettier/vim-prettier'
    use 'editorconfig/editorconfig-vim'

    if packer_bootstrap then
        print('packer bootstrap')
        require('packer').sync()
    end
end)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'tpope/vim-vinegar',
        keys = '-',
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('x.lsp').setup()
        end
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'honza/vim-snippets',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('x.cmp').setup()
            require('x.luasnip').setup()
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('x.treesitter').setup()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
            },
        },
        config = function()
            require('x.telescope').setup()
        end,
    },
    {
        'smoka7/hop.nvim',
        config = function()
            require('hop').setup()
        end,
        lazy = true,
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'jiangmiao/auto-pairs',
        config = function()
            require('x.auto_pairs').setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        'majutsushi/tagbar',
        cmd = 'TagbarToggle',
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup {}
        end
    },
    {
        'mfussenegger/nvim-dap',
        config = function()
            require('x.dap').setup()
        end,
        lazy = true,
    },
    {
        'github/copilot.vim',
        lazy = true,
    },
    {
        'dinhhuy258/vim-local-history',
        build = ':UpdateRemotePlugins',
        config = function()
            require('x.local_history').setup()
        end
    },
    {
        'iamcco/markdown-preview.nvim',
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = 'markdown',
    },
    {
        'prettier/vim-prettier',
        cmd = 'Prettier',
    },
    {
        'folke/neodev.nvim',
    },
    -- scroll makes my eyes tired.
    -- {
    --     'karb94/neoscroll.nvim',
    --     config = function()
    --         require('x.scroll').setup()
    --     end,
    -- }
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require('x.indent_guide').setup()
        end
    },
})

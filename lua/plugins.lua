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

require("lazy").setup({
    {
        "stevearc/oil.nvim",
        config = function()
            require("x.oil").setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "folke/neodev.nvim",
        },
        config = function()
            require("x.lsp").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            require("x.treesitter").setup()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "honza/vim-snippets",
        },
        build = "make install_jsregexp",
        config = function()
            require("x.luasnip").setup()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("x.cmp").setup()
        end,
        event = "InsertEnter",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
        config = function()
            require("x.telescope").setup()
        end,
    },
    {
        "smoka7/hop.nvim",
        config = function()
            require("hop").setup()
        end,
        cmd = "HopPattern",
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
        event = "InsertEnter",
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            require("x.gitsigns").setup()
        end,
    },
    {
        "majutsushi/tagbar",
        cmd = "TagbarToggle",
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({})
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("x.dap").setup()
        end,
    },
    {
        "github/copilot.vim",
        init = function()
            require("x.copilot").init()
        end,
        cmd = "Copilot",
    },
    {
        "dinhhuy258/vim-local-history",
        build = ":UpdateRemotePlugins",
        init = function()
            require("x.local_history").init()
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        ft = "markdown",
    },
    {
        "prettier/vim-prettier",
        cmd = "Prettier",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("x.indent_guide").setup()
        end,
    },
    {
        "dhruvasagar/vim-table-mode",
        init = function()
            require("x.table_mode").init()
        end,
    }
})

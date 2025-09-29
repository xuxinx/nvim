local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local lazyFile = { "BufReadPost", "BufWritePost", "BufNewFile" }

require("lazy").setup({
    {
        "stevearc/oil.nvim",
        config = function()
            require("x.oil").setup()
        end,
        cmd = "Oil",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("x.lsp").setup()
        end,
    },
    {
        "folke/lazydev.nvim",
        config = function()
            require("x.lazydev").setup()
        end,
        ft = "lua",
        cmd = "LazyDev",
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
        event = lazyFile,
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
        lazy = true,
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
                "make",
            },
        },
        config = function()
            require("x.telescope").setup()
        end,
        cmd = "Telescope",
    },
    {
        "smoka7/hop.nvim",
        config = function()
            require("hop").setup()
        end,
        cmd = "HopChar1MW",
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
        event = lazyFile,
    },
    {
        "majutsushi/tagbar",
        init = function()
            require("x.tagbar").init()
        end,
        cmd = "TagbarToggle",
    },
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({})
        end,
        event = lazyFile,
    },
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("x.dap").setup()
        end,
        lazy = true,
    },
    {
        "github/copilot.vim",
        init = function()
            require("x.copilot").init()
        end,
        event = "InsertEnter",
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "github/copilot.vim",
            "nvim-lua/plenary.nvim",
        },
        build = "make tiktoken",
        config = function()
            require("x.copilot_chat").setup()
        end,
        cmd = "CopilotChatToggle",
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
        "stevearc/conform.nvim",
        config = function()
            require("x.conform").setup()
        end,
        event = "BufWritePre",
        cmd = "ConformInfo",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("x.indent_guide").setup()
        end,
        event = lazyFile,
    },
    {
        "dhruvasagar/vim-table-mode",
        init = function()
            require("x.table_mode").init()
        end,
        cmd = "TableModeEnable",
    },
    {
        "mistweaverco/kulala.nvim",
        config = function()
            require("x.kulala").setup()
        end,
        ft = "http",
    },
})

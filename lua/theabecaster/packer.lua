-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- lua/plugins/rose-pine.lua
    use {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    }

    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    -- LSP and Mason setup
    use {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup()
        end
    }
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    -- Copilot integration for nvim-cmp
    use {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({})
        end
    }
    use {
        "zbirenbaum/copilot-cmp",
        after = {"copilot.lua"},
        config = function()
            require("copilot_cmp").setup()
        end
    }

    -- Code formatting
    use {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    json = { "prettier" },
                    rust = { "rustfmt" },
                    go = { "gofmt" },
                },
            })
        end
    }

    -- Fun animations
    use 'eandrju/cellular-automaton.nvim'
    
    -- Claude Code integration
    use 'coder/claudecode.nvim'
end)

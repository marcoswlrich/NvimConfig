return require("packer").startup(function(use)


    use "wbthomason/packer.nvim" --> packer plugin
    use "EdenEast/nightfox.nvim" --> colorschemes
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    -- LSP ---
    use 'nvim-lua/plenary.nvim' -- Common utilities
    use 'onsails/lspkind-nvim' -- vscode-like pictograms
    use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
    use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
    use 'hrsh7th/nvim-cmp' -- Completion
    use 'neovim/nvim-lspconfig' -- LSP
    use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
    use 'MunifTanjim/prettier.nvim' -- Prettier plugin for Neovim's built-in LSP client
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use 'glepnir/lspsaga.nvim' -- LSP UIs
    use 'L3MON4D3/LuaSnip'
    
end)

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Plugin Mangager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Lua Development
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "nvim-lua/popup.nvim"

  use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

  use 'nvim-lualine/lualine.nvim'
  use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  --Tree
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"

  -- Colorschemes
  use "lunarvim/onedarker.nvim"
  use "folke/tokyonight.nvim"
  use "EdenEast/nightfox.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'rmehri01/onenord.nvim'
  use "ellisonleao/gruvbox.nvim"
  use { 'rose-pine/neovim', as = 'rose-pine' }

  --LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  --CMP
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jay-babu/mason-null-ls.nvim'

  use "windwp/nvim-autopairs"
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'windwp/nvim-ts-autotag'
  use 'p00f/nvim-ts-rainbow'
  use 'axelvc/template-string.nvim'
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
  })

  --Color
  use "NvChad/nvim-colorizer.lua"

  use 'numToStr/Comment.nvim'
  use({
    'akinsho/toggleterm.nvim',
    tag = '*'
  })

  --git
  use 'lewis6991/gitsigns.nvim'



  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

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
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "christoomey/vim-tmux-navigator",
  'nvim-lualine/lualine.nvim',
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    version = '^1.0.0',              -- optional: only update when a new 1.x version is released
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- or                              , branch = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  "EdenEast/nightfox.nvim",
  { "catppuccin/nvim",    name = "catppuccin", priority = 1000 },
  "rmehri01/onenord.nvim",
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { 'rose-pine/neovim',         name = 'rose-pine' },
  {
    'goolord/alpha-nvim',
    enabled = true,
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "1.2.1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  },
  "onsails/lspkind-nvim",
  "saadparwaiz1/cmp_luasnip",
  "jose-elias-alvarez/typescript.nvim",
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  "jose-elias-alvarez/null-ls.nvim",
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  "nvim-treesitter/nvim-treesitter-context",
  "windwp/nvim-ts-autotag",
  "HiPhish/nvim-ts-rainbow2",
  "axelvc/template-string.nvim",
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  "norcalli/nvim-colorizer.lua",
  "numToStr/Comment.nvim",
  { 'akinsho/toggleterm.nvim', version = "*", },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },
  { '0x100101/lab.nvim',       build = 'cd js && npm ci', dependencies = { 'nvim-lua/plenary.nvim' } },
  "karb94/neoscroll.nvim",
  "nacro90/numb.nvim",
  "petertriho/nvim-scrollbar",
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "folke/neodev.nvim",
    },
  },
  "folke/zen-mode.nvim",
  "wakatime/vim-wakatime",
  "lewis6991/gitsigns.nvim",
  "f-person/git-blame.nvim",
  {
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },
  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = true
  },
  -- `GistsList` opens the selected gif in a terminal buffer,
  -- nvim-unception uses neovim remote rpc functionality to open the gist in an actual buffer
  -- and prevents neovim buffer inception
  {
    "samjwill/nvim-unception",
    lazy = false,
    init = function() vim.g.unception_block_while_host_edits = true end
  },
  "MattesGroeger/vim-bookmarks",
  "tom-anders/telescope-vim-bookmarks.nvim",
  "leoluz/nvim-dap-go",
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter"
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    enabled = true,
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    config = function()
      require('fidget').setup()
    end
  }
})

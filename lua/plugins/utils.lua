return {
  "wakatime/vim-wakatime",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "christoomey/vim-tmux-navigator",
  "folke/neodev.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  {
    'numToStr/Comment.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('Comment').setup()
    end,
  },
  {
    "nacro90/numb.nvim",
    config = function()
      local status_ok, numb = pcall(require, "numb")
      if not status_ok then
        return
      end
      numb.setup({
        show_numbers = true,    -- Enable 'number' for the window while peeking
        show_cursorline = true, -- Enable 'cursorline' for the window while peeking
      })
    end,
  },
  {
    "editorconfig/editorconfig-vim",
    lazy = true,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>j', '<space>J' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
      -- For use default preset and it work with dot
      vim.keymap.set('n', '<leader>j', require('treesj').toggle)
      -- For extending default preset with `recursive = true`, but this doesn't work with dot
      vim.keymap.set('n', '<leader>J', function()
        require('treesj').toggle({ split = { recursive = true } })
      end)
    end,
  },
  {
    'ziglang/zig.vim',
    ft = "zig",
  },

}

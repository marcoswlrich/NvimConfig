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
}

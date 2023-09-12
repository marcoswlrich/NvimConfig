return {
  { 'wakatime/vim-wakatime' },
  { "folke/neoconf.nvim",            cmd = "Neoconf" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "christoomey/vim-tmux-navigator" },
  {
    'numToStr/Comment.nvim',
    lazy = false,
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

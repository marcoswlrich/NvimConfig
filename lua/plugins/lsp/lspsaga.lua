return {
  "nvimdev/lspsaga.nvim",
  config = function()
    local status, saga = pcall(require, "lspsaga")
    if not status then
      return
    end

    saga.setup({
      symbol_in_winbar = {
        enable = true,
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons",     -- optional
  },
}

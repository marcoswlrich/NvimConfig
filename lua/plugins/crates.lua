return {
  "saecki/crates.nvim",
  enabled = true,
  version = "v0.3.0",
  lazy = true,
  ft = { "rust", "toml" },
  event = { "BufRead", "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("crates").setup({
      null_ls = {
        enabled = false,
        name = "Crates",
      },
      popup = {
        border = "rounded",
      },
    })
  end
}

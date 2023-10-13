return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = true,
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup({
      indent = {
        char = '┊',
      },
      scope = {
        enabled = false,
        show_start = false,
        show_end = false,
      }
    });
  end

}

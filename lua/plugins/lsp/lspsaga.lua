return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    local status, saga = pcall(require, "lspsaga")
    if not status then
      return
    end

    local keymap = vim.keymap.set

    saga.setup({
      ui = {
        border = "rounded",
      },
      symbol_in_winbar = {
        enable = true,
      },
      lightbulb = {
        enable = false,
      },
      outline = {
        layout = "float",
      },
    })

    local opts = { noremap = true, silent = true }
    keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    keymap("n", "gl", "<Cmd>Lspsaga show_diagnostic<CR>", opts)
    keymap("n", "<leader>K", "<cmd>Lspsaga hover_doc<CR>", opts)
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
    keymap("n", "gd", "<cmd><cmd>Lspsaga peek_definition<CR><CR>", opts)
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)

    local codeaction = require("lspsaga.codeaction")
    vim.keymap.set("n", "<leader>ca", function()
      codeaction:code_action()
    end, { silent = true })
    vim.keymap.set("v", "<leader>ca", function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
      codeaction:range_code_action()
    end, { silent = true })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons",     -- optional
  },
}

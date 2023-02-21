local keymap = vim.keymap.set

require('lspsaga').setup({
  ui = {
    border = 'rounded',
  }
})

keymap("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>")

keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

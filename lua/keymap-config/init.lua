M = {}
local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

---------------------
-- General Keymaps
---------------------

keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)
keymap("n", "<C-i>", "<C-i>", opts)

----------------------
-- Plugin Keybinds
----------------------

keymap("n", "<leader>e", '<cmd>NvimTreeToggle<cr>', opts)

--telescope


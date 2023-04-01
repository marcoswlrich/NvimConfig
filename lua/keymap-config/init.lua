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

-- WINDOWS
keymap("n", "<leader>sv", "<C-w>v", opts) -- abrir janela vertical
keymap("n", "<leader>sh", "<C-w>s", opts) -- abri janela horizontal
keymap("n", "<leader>se", "<C-w>=", opts) -- deixar janelas abertas com mesmo tamanho
keymap("n", "<leader>sx", ":close<CR>", opts) -- close split window
--keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)

----------------------
-- Plugin Keybinds
----------------------

keymap("n", "<leader>e", '<cmd>NvimTreeToggle<cr>', opts)
-- Terminal
keymap("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>", opts)

--telescope

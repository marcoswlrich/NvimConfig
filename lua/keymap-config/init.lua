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

keymap("i", "jk", "<ESC>", opts)

-- WINDOWS
keymap("n", "<leader>sv", "<C-w>v", opts) -- abrir janela vertical
keymap("n", "<leader>sh", "<C-w>s", opts) -- abri janela horizontal
keymap("n", "<leader>se", "<C-w>=", opts) -- deixar janelas abertas com mesmo tamanho
keymap("n", "<leader>sx", ":close<CR>", opts) -- close split window
--keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)

------------------
--VisuaL Mode
------------------
keymap('v', '<c-a>', 'gg<S-v>G', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)

-- Paste
keymap('v', 'p', '"_dP', opts)
keymap('x', '<leader>pp', '"_dP', opts)

-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)


----------------------
-- Plugin Keybinds
----------------------

keymap("n", "<leader>e", '<cmd>NvimTreeToggle<cr>', opts)
-- Terminal
keymap("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>", opts)

--telescope

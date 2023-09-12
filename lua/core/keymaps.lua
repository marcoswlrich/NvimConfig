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

keymap("i", "jj", "<ESC>", opts)
keymap("i", "jk", "<ESC>", opts)

-- WINDOWS
keymap("n", "<leader>sv", "<C-w>v", opts)     -- abrir janela vertical
keymap("n", "<leader>sh", "<C-w>s", opts)     -- abri janela horizontal
keymap("n", "<leader>se", "<C-w>=", opts)     -- deixar janelas abertas com mesmo tamanho
keymap("n", "<leader>sx", ":close<CR>", opts) -- close split window
--keymap("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>", opts)

-- Mantenha o cursor centralizado ao rolar
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Remapear para lidar com quebras de linha visual
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- copie tudo entre { e } incluindo os colchetes
-- p coloca o texto após o cursor,
-- P coloca o texto antes do cursor.
keymap("n", "YY", "va{Vy", opts)

keymap("n", "+", ":vertical resize +5<CR>", opts)
keymap("n", "_", ":vertical resize -5<CR>", opts)
keymap("n", "=", ":resize +5<CR>", opts)
keymap("n", "-", ":resize -5<CR>", opts)
------------------
--VisuaL Mode
------------------
keymap("v", "<c-a>", "gg<S-v>G", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Paste
keymap("v", "p", '"_dP', opts)
keymap("v", "P", '"_dP', opts)

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

----------------------
----------------------

-- Terminal
keymap("n", "<leader>th", "<CMD>ToggleTerm size=10 direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>", opts)

--Barbar buffers
keymap("n", "<A-1>", ":BufferGoto 1<CR>", opts)
keymap("n", "<A-2>", ":BufferGoto 2<CR>", opts)
keymap("n", "<A-3>", ":BufferGoto 3<CR>", opts)
keymap("n", "<A-4>", ":BufferGoto 4<CR>", opts)
keymap("n", "<A-5>", ":BufferGoto 5<CR>", opts)
keymap("n", "<A-6>", ":BufferGoto 6<CR>", opts)
keymap("n", "<A-7>", ":BufferGoto 7<CR>", opts)
keymap("n", "<A-8>", ":BufferGoto 8<CR>", opts)
keymap("n", "<A-9>", ":BufferGoto 9<CR>", opts)
keymap("n", "<A-.>", ":BufferNext<CR>", opts)
keymap("n", "<A-0>", ":BufferLast<CR>", opts)
keymap("n", "<A-c>", ":BufferClose<CR>", opts)
keymap("n", "<A-s-c>", ":BufferRestore<CR>", opts)
keymap("n", "<A-,>", ":BufferPrevious<CR>", opts)
-- Plugin Keybinds

local opt = vim.opt -- for conciseness

opt.backup = false
opt.writebackup = false
opt.cmdheight = 1
opt.pumheight = 10
opt.timeoutlen = 1000

opt.hlsearch = true
opt.incsearch = true

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.smartindent = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.showmode = false
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word
opt.mouse = "a"

opt.fileencoding = "utf-8"
opt.encoding = 'utf-8'
opt.numberwidth = 4
opt.guifont = "monospace:h17"

opt.completeopt = "menuone,noselect"

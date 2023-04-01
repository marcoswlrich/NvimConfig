require('options')
require("packer-plugins")
vim.cmd("colorscheme rose-pine-moon") -- duskfox nordfox tokyonight-night/storm/moon/
require("keymap-config") -- catppuccin-frappe/macchiato/mocha  rose-pine
require("tree-config")
require("lualine-config")
require("barbar-config")
require("lsp.lsp-config")
require("lsp.mason")
require("lsp.null")
require("cmp-config.cmp")
require("cmp-config.lspkind")
require("cmp-config.snip")
require("autopairs-config")
require("telescope-config")
--require("bookmark-config")
require("treesitter-config")
require("ts-context")
require('lsp.lspsaga')
require('colorizer-config')
require('utils')
require('gitsigns-config')
require('alpha-config')

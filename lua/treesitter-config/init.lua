require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "tsx",
    "lua",
    "python",
    "rust",
    "json",
    "graphql",
    "regex",
    "vim",
    "yaml",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "dockerfile"
  },
  context_commentstring = {
    enable = true,
  },

  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {}
  },
  autotag = {
    enable = true
  },
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  }
}

require('template-string').setup({
  filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'python' }, -- filetypes where the plugin is active
  jsx_brackets = true,                                                                        -- must add brackets to jsx attributes
  remove_template_string = false,                                                             -- remove backticks when there are no template string
  restore_quotes = {
    -- quotes used when "remove_template_string" option is enabled
    normal = [[']],
    jsx = [["]],
  },
})

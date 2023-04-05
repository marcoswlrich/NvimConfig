require("mason").setup({
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})
require("mason-lspconfig").setup({
  ensure_installed = {
    'lua_ls',
    'tsserver',
    'graphql',
    'rust_analyzer',
    'yamlls',
    'cssls',
    'cssmodules_ls',
    'emmet_ls',
    'html',
    'jdtls',
    'jsonls',
    'pyright'
  },
  automatic_installation = true,
})

require('mason-null-ls').setup({
  ensure_installed = {
    "prettier",
    "stylua",
    "eslint_d",
  },
  automatic_installation = true,
})

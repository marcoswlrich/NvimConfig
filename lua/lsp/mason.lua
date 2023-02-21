require("mason").setup()
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

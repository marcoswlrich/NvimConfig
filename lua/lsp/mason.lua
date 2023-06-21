require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"tsserver",
		"graphql",
		"rust_analyzer",
		"yamlls",
		"clangd",
		"cssls",
		"cssmodules_ls",
		"emmet_ls",
		"html",
		"jdtls",
		"jsonls",
		"pyright",
	},
	automatic_installation = true,
})

require("mason-null-ls").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"eslint_d",
		"mypy",
		"ruff",
		"black",
	},
	automatic_installation = true,
	handlers = {},
})

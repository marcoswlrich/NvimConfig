require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"tsx",
		"c",
		"cpp",
		"lua",
		"python",
		"rust",
		"go",
		"gomod",
		"json",
		"graphql",
		"javascript",
		"regex",
		"vim",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"dockerfile",
		"typescript",
		"astro",
	},
	context_commentstring = {
		enable = true,
	},

	sync_install = false,
	auto_install = true,
	ignore_install = {},

	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = {},
	},
	autotag = {
		enable = true,
	},
})

require("template-string").setup({
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" }, -- filetypes where the plugin is active
	jsx_brackets = true, -- must add brackets to jsx attributes
	remove_template_string = false, -- remove backticks when there are no template string
	restore_quotes = {
		-- quotes used when "remove_template_string" option is enabled
		normal = [[']],
		jsx = [["]],
	},
})

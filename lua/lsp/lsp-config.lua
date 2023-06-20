local on_attach = function(_, bufnr)
	-- format on save
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format()
		end,
	})
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local util = require("lspconfig/util")

local lsp_config = {
	capabilities = capabilities,
	group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
	on_attach = function(_, bufnr)
		on_attach(_, bufnr)
	end,
}

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup(lsp_config)
	end,
	lua_ls = function()
		require("lspconfig").lua_ls.setup(vim.tbl_extend("force", lsp_config, {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		}))
	end,
	tsserver = function()
		require("typescript").setup({
			server = vim.tbl_extend("force", lsp_config, {
				on_attach = function(_, bufnr)
					on_attach(_, bufnr)
				end,
				init_options = {
					preferences = {
						importModuleSpecifierPreference = "project=relative",
						jsxAttributeCompletionStyle = "none",
					},
				},
			}),
		})
	end,
	pyright = function()
		require("lspconfig").pyright.setup(vim.tbl_extend("force", lsp_config, {
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)
			end,
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						autoImportCompletions = true,
						typeCheckingMode = "off",
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
					},
				},
			},
			single_file_suport = true,
		}))
	end,
	ruff_lsp = function()
		require("lspconfig").ruff_lsp.setup(vim.tbl_extend("force", lsp_config, {
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)
			end,
			init_options = {
				settings = {
					-- Any extra CLI arguments for `ruff` go here.
					args = { "--max-line-length=180" },
				},
			},
		}))
	end,
	rust_analyzer = function()
		require("lspconfig").rust_analyzer.setup(vim.tbl_extend("force", lsp_config, {
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)
			end,
			cmp = { "rustup", "run", "stable", "rust-analyzer" },
			filetypes = { "rust" },
			root_dir = util.root_pattern("Cargo.toml"),
			settings = {
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
					},
					lens = {
						enable = true,
					},
					checkOnSave = {
						enable = true,
						command = "clippy",
					},
				},
			},
		}))
	end,
	tailwindcss = function()
		require("lspconfig").tailwindcss.setup(vim.tbl_extend("force", lsp_config, {
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)
			end,
			cmp = { "tailwindcss-language-server", "--stdio" },
			filetypes = {
				"aspnetcorerazor",
				"astro",
				"astro-markdown",
				"blade",
				"clojure",
				"django-html",
				"htmldjango",
				"edge",
				"eelixir",
				"elixir",
				"ejs",
				"erb",
				"eruby",
				"gohtml",
				"haml",
				"handlebars",
				"hbs",
				"html",
				"html-eex",
				"heex",
				"jade",
				"leaf",
				"liquid",
				"markdown",
				"mdx",
				"mustache",
				"njk",
				"nunjucks",
				"php",
				"razor",
				"slim",
				"twig",
				"css",
				"less",
				"postcss",
				"sass",
				"scss",
				"stylus",
				"sugarss",
				"javascript",
				"javascriptreact",
				"reason",
				"rescript",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
			},
			init_options = {
				userLanguages = {
					eelixir = "html-eex",
					eruby = "erb",
				},
			},
		}))
	end,
	clangd = function()
		require("lspconfig").clangd.setup(vim.tbl_extend("force", lsp_config, {
			on_attach = function(_, bufnr)
				on_attach(_, bufnr)
			end,
			cmp = { "clangd" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			init_options = {
				buildDirectory = "build",
			},
		}))
	end,
})

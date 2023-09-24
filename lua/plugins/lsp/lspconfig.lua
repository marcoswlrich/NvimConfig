return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    --{ "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local on_attach = function(_, bufnr)
      -- format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end



    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = false,
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
    })

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticsSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config({
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true,
      severity_sort = true,
      float = {
        source = "always",
        style = "minimal",
        border = "rounded",
        header = "",
        prefix = "",
      },
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local util = require("lspconfig/util")
    local clang_capabilities = capabilities
    clang_capabilities.textDocument.semanticHighlighting = true
    clang_capabilities.offsetEncoding = "utf-8"
    clang_capabilities.signatureHelpProvider = false


    local function get_typescript_server_path(root_dir)
      local project_root = util.find_node_modules_ancestor(root_dir)
      return project_root and (util.path.join(project_root, 'node_modules', 'typescript', 'lib')) or ''
    end




    local lsp_config = {
      capabilities = capabilities,
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    }

    local lsp_config_clangd = {
      capabilities = clang_capabilities,
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
        require("lspconfig").tsserver.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
          filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
          cmd = { "typescript-language-server", "--stdio" },
        }))
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
          cmd = { "rustup", "run", "stable", "rust-analyzer" },
          filetypes = { "rust" },
          root_dir = util.root_pattern("Cargo.toml", "rust-project.json"),
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
      gopls = function()
        require("lspconfig").gopls.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", ".git" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        }))
      end,
      graphql = function()
        require("lspconfig").graphql.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "graphql-lsp", "server", "-m", "stream" },
          filetypes = { "graphql", "typescriptreact", "javascriptreact" },
          root_dir = util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*')
        }))
      end,
      marksman = function()
        require("lspconfig").marksman.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "marksman", "server" },
          filetypes = { "markdown" },
          root_dir = util.root_pattern(".git", ".marksman.toml"),
          single_file_suport = true,
        }))
      end,
      astro = function()
        require("lspconfig").astro.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "astro-ls", "--stdio" },
          filetypes = { "astro" },
          root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
          init_options = {
            typescript = {},
          },
          on_new_config = function(new_config, new_root_dir)
            if vim.tbl_get(new_config.init_options, 'typescript') and not new_config.init_options.typescript.tsdk then
              new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
            end
          end,
        }))
      end,
      tailwindcss = function()
        require("lspconfig").tailwindcss.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "tailwindcss-language-server", "--stdio" },
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
        require("lspconfig").clangd.setup(vim.tbl_extend("force", lsp_config_clangd, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "clangd" },
          root_dir = util.root_pattern(
            ".clangd",
            ".clang-tidy",
            ".clang-format",
            "compile_commands.json",
            "compile_flags.txt",
            "configure.ac",
            ".git"
          ),
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
          init_options = {
            buildDirectory = "build",
          },
          single_file_support = true,
        }))
      end,
    })
  end,
}

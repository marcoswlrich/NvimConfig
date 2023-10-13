return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
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
    clang_capabilities.textDocument.completion.editsNearCursor = true
    clang_capabilities.offsetEncoding = { 'utf-8', 'utf-16' }
    clang_capabilities.signatureHelpProvider = false

    -- https://clangd.llvm.org/extensions.html#switch-between-sourceheader
    local function switch_source_header(bufnr)
      bufnr = util.validate_bufnr(bufnr)
      local clangd_client = util.get_active_client_by_name(bufnr, 'clangd')
      local params = { uri = vim.uri_from_bufnr(bufnr) }
      if clangd_client then
        clangd_client.request('textDocument/switchSourceHeader', params, function(err, result)
          if err then
            error(tostring(err))
          end
          if not result then
            print 'Corresponding file cannot be determined'
            return
          end
          vim.api.nvim_command('edit ' .. vim.uri_to_fname(result))
        end, bufnr)
      else
        print 'method textDocument/switchSourceHeader is not supported by any servers active on the current buffer'
      end
    end

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
          cmd = { "lua-language-server" },
          filetypes = { "lua" },
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          completion = { enable = true, callSnippet = "Replace" },
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim", "describe" },
              },
            },
          },
          workspace = {
            checkThirdParty = false,
            -- adjust these two values if your performance is not optimal
            maxPreload = 2000,
            preloadFileSize = 1000,
          },
          telemetry = { enable = false },
        }))
      end,
      tsserver = function()
        require("lspconfig").tsserver.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
          filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact',
            'typescript.tsx', 'vue', 'svelte' },
          cmd = { "typescript-language-server", "--stdio" },
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
              suggest = {
                includeCompletionsForModuleExports = true,
              },
            },
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- false
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- false
              },
              suggest = {
                includeCompletionsForModuleExports = true,
              },
            },
          },
        }))
      end,
      emmet_ls = function()
        require("lspconfig").emmet_ls.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { 'emmet-ls', '--stdio' },
          filetypes = {
            'astro',
            'css',
            'eruby',
            'html',
            'htmldjango',
            'javascriptreact',
            'less',
            'pug',
            'sass',
            'scss',
            'svelte',
            'typescriptreact',
            'vue',
          },
          root_dir = util.find_git_ancestor,
          single_file_support = true,
        }))
      end,
      pyright = function()
        require("lspconfig").pyright.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { "pyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_dir = util.root_pattern('pyproject.toml',
            'setup.py',
            'setup.cfg',
            'requirements.txt',
            'Pipfile',
            'pyrightconfig.json',
            '.git'),
          single_file_support = true,
          settings = {
            python = {
              disableOrganizeImports = false,
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "off",
                autoSearchPaths = true,
                diagnosticMode = { "openFilesOnly", "workspace" },
                useLibraryCodeForTypes = true,
              },
            },
          },
        }))
      end,
      ruff_lsp = function()
        require("lspconfig").ruff_lsp.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { 'ruff-lsp' },
          filetypes = { 'python' },
          root_dir = util.root_pattern('pyproject.toml', 'ruff.toml'),
          init_options = {
            settings = {
              -- Any extra CLI arguments for `ruff` go here.
              args = { "--max-line-length=180" },
            },
          },
          single_file_support = true,
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
              imports = {
                granularity = {
                  group = "module",
                },
                prefix = "self",
              },
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              lens = {
                enable = true,
              },
              checkOnSave = {
                enable = true,
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
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
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                fieldalignment = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
              },
              staticcheck = true,
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            },
          },
          commands = {
            -- imports all packages used but not defined into the file
            GoImportAll = {
              function()
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { 'source.organizeImports' } }
                ---@diagnostic disable-next-line: param-type-mismatch
                local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
                for _, res in pairs(result or {}) do
                  for _, r in pairs(res.result or {}) do
                    if r.edit then
                      vim.lsp.util.apply_workspace_edit(r.edit, 'UTF-8')
                    else
                      vim.lsp.buf.execute_command(r.command)
                    end
                  end
                end
              end,
              description = 'Import all used packages into the file',
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
          filetypes = { "graphql", "typescriptreact", "javascriptreact", "javascript", "typescript", },
          root_dir = util.root_pattern('.graphqlrc*', '.graphql.config.*', 'graphql.config.*')
        }))
      end,
      jsonls = function()
        require("lspconfig").jsonls.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          settings = {
            json = {
              schemas = require('schemastore').json.schemas {
                select = {
                  '.eslintrc',
                  'package.json',
                  'tsconfig.json',
                  'Packer',
                  'prettierrc.json',
                  'Deno',
                  'compilerconfig.json',
                },
              },
              validate = { enable = true },
            },
          },
        }))
      end,
      yamlls = function()
        require("lspconfig").yamlls.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          settings = {
            yaml = {
              schemaStore = {
                -- You must disable built-in schemaStore support if you want to use
                -- this plugin and its advanced options like `ignore`.
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = require('schemastore').yaml.schemas({
                select = {
                  "kustomization.yaml",
                  "clangd",
                  "Alacritty Configuration",
                }
              }),
            },
          },
        }))
      end,
      prismals = function()
        require("lspconfig").prismals.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { 'prisma-language-server', '--stdio' },
          filetypes = { 'prisma' },
          settings = {
            prisma = {
              prismaFmtBinPath = '',
            },
          },
          root_dir = util.root_pattern('.git', 'package.json'),
        }))
      end,
      zls = function()
        require("lspconfig").zls.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          cmd = { 'zls' },
          filetypes = { 'zig', 'zir' },
          root_dir = util.root_pattern('zls.json', '.git'),
          single_file_support = true,
        }))
      end,
      eslint = function()
        require("lspconfig").eslint.setup(vim.tbl_extend("force", lsp_config, {
          on_attach = function(_, bufnr)
            on_attach(_, bufnr)
          end,
          filestypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
          settings = {
            workingDirectory = { mode = 'auto' },
            format = { enable = true },
            lint = { enable = true },
          },
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
          settings = {
            tailwindCSS = {
              validate = true,
              codeActions = true,
              colorDecorators = true,
              emmetCompletions = false,
              hovers = true,
              rootFontSize = 16,
              showPixelEquivalents = true,
              suggestions = true,
              lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
              },
              classAttributes = {
                'class',
                'className',
                'class:list',
                'classList',
                'ngClass',
              },
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
          single_file_support = true,
          commands = {
            ClangdSwitchSourceHeader = {
              function()
                switch_source_header(0)
              end,
              description = 'Switch between source/header',
            },
          },
        }))
      end,
    })
  end,
}

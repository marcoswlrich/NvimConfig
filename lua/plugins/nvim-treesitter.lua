return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "HiPhish/nvim-ts-rainbow2",
      "axelvc/template-string.nvim",
      'JoosepAlviste/nvim-ts-context-commentstring',

    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "tsx",
          "c",
          "cpp",
          "lua",
          "python",
          "rust",
          "go",
          "vue",
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
          enable_autocmd = false,
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

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>vv",
            node_incremental = "+",
            scope_incremental = false,
            node_decremental = "_",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = { query = "@function.outer", desc = "around a function" },
              ["if"] = { query = "@function.inner", desc = "inner part of a function" },
              ["ac"] = { query = "@class.outer", desc = "around a class" },
              ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
              ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
              ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
              ["al"] = { query = "@loop.outer", desc = "around a loop" },
              ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
              ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
              ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v",   -- charwise
              ["@parameter.inner"] = "v",   -- charwise
              ["@function.outer"] = "v",    -- charwise
              ["@conditional.outer"] = "V", -- linewise
              ["@loop.outer"] = "V",        -- linewise
              ["@class.outer"] = "<c-v>",   -- blockwise
            },
            include_surrounding_whitespace = false,
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Previous function" },
              ["[c"] = { query = "@class.outer", desc = "Previous class" },
              ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
            },
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function" },
              ["]c"] = { query = "@class.outer", desc = "Next class" },
              ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })

      require("template-string").setup({
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" }, -- filetypes where the plugin is active
        jsx_brackets = true,                                                                        -- must add brackets to jsx attributes
        remove_template_string = false,                                                             -- remove backticks when there are no template string
        restore_quotes = {
          -- quotes used when "remove_template_string" option is enabled
          normal = [[']],
          jsx = [["]],
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require 'treesitter-context'.setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,
        line_numbers = true,
        multiline_threshold = 20, -- How many lines the window should span. Values <= 0 mean no limit.
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        min_window_height = 0,
        on_attach = nil,
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
            'interface',
            'struct',
            'enum',
          },
          -- Patterns for specific filetypes
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
          },
          haskell = {
            'adt'
          },
          rust = {
            'impl_item',

          },
          terraform = {
            'block',
            'object_elem',
            'attribute',
          },
          scala = {
            'object_definition',
          },
          vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
          },
          markdown = {
            'section',
          },
          elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
          },
          json = {
            'pair',
          },
          typescript = {
            'export_statement',
          },
          yaml = {
            'block_mapping_pair',
          },
        },
        exact_patterns = {
          -- Example for a specific filetype with Lua patterns
          -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
          -- exactly match "impl_item" only)
          -- rust = true,
        },

        -- [!] The options below are exposed but shouldn't require your attention,
        --     you can safely ignore them.

        zindex = 20,     -- The Z-index of the context window
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
      }
    end
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "axelvc/template-string.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        ignore_install = { "javascript" },
        modules = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        -- context_commentstring = { enable = true, enable_autocmd = false },
        auto_install = true,
        ensure_installed = {
          -- "bash",
          "c",
          "cpp",
          "html",
          "css",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vue",
          "vim",
          "vimdoc",
          "yaml",
          "rust",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "terraform",
          "proto",
          "graphql",
          "dockerfile",
          "astro",
          "zig",
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
        autotag = {
          enable = true,
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
              ["@parameter.outer"] = "v", -- charwise
              ["@parameter.inner"] = "v", -- charwise
              ["@function.outer"] = "v", -- charwise
              ["@conditional.outer"] = "V", -- linewise
              ["@loop.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
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
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte", "python" }, -- filetypes where the plugin is active
        jsx_brackets = true, -- must add brackets to jsx attributes
        remove_template_string = false, -- remove backticks when there are no template string
        restore_quotes = {
          -- quotes used when "remove_template_string" option is enabled
          normal = [[']],
          jsx = [["]],
        },
      })
    end,
  },
}

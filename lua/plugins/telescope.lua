return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  version = false,
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jvgrootveld/telescope-zoxide',
    'nvim-tree/nvim-web-devicons',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-ui-select.nvim',
    'telescope-dap.nvim',
    'kkharji/sqlite.lua',
    'nvim-telescope/telescope-frecency.nvim',
    -- {
    --   "nvim-telescope/telescope-file-browser.nvim",
    --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    -- }
  },
  config = function()
    -- import telescope plugin safely
    local telescope_setup, telescope = pcall(require, "telescope")
    if not telescope_setup then
      return
    end

    -- import telescope actions safely
    local actions_setup, actions = pcall(require, "telescope.actions")
    if not actions_setup then
      return
    end
    require('nvim-web-devicons').setup({
      override = {},
      default = true
    })

    -- configure telescope
    telescope.setup({
      -- configure custom mappings
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<esc>"] = actions.close
          },
        },
        file_ignore_patterns = {
          ".git/",
          "target/",
          "docs/",
          "vendor/*",
          "%.lock",
          "__pycache__/*",
          "%.sqlite3",
          "%.ipynb",
          "node_modules/*",
          -- "%.jpg",
          -- "%.jpeg",
          -- "%.png",
          "%.svg",
          "%.otf",
          "%.ttf",
          "%.webp",
          ".dart_tool/",
          ".github/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vscode/",
          "__pycache__/",
          "build/",
          "env/",
          "gradle/",
          "node_modules/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          "%.pdf",
          "%.dylib",
          "%.jar",
          "%.docx",
          "%.met",
          "smalljre_*/*",
          ".vale/",
          "%.burp",
          "%.mp4",
          "%.mkv",
          "%.rar",
          "%.zip",
          "%.7z",
          "%.tar",
          "%.bz2",
          "%.epub",
          "%.flac",
          "%.tar.gz",
        },
        prompt_prefix = "   ",
      },
      layout_config = {
        prompt_position = "top",
        preview_cutoff = 120,
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",
          previewer = true,
          layout_config = {
            -- width = 0.5,
            height = 0.8,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        git_files = {
          previewer = true,
          -- theme = "dropdown",
          layout_config = {
            -- width = 0.5,
            height = 0.8,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        buffers = {
          previewer = false,
          -- theme = "dropdown",
          layout_config = {
            width = 0.5,
            height = 0.4,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        current_buffer_fuzzy_find = {
          previewer = true,
          -- theme = "dropdown",
          layout_config = {
            -- width = 0.5,
            height = 0.8,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        live_grep = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        grep_string = {
          only_sort_text = true,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        lsp_references = {
          show_line = false,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
        treesitter = {
          show_line = false,
          previewer = true,
          layout_config = {
            horizontal = {
              width = 0.9,
              height = 0.75,
              preview_width = 0.6,
            },
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            previewer        = false,
            initial_mode     = "normal",
            sorting_strategy = 'ascending',
            layout_strategy  = 'horizontal',
            layout_config    = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          })
        },
        frecency = {
          default_workspace = 'CWD',
          show_scores = true,
          show_unindexed = true,
          disable_devicons = false,
          ignore_patterns = {
            "*.git/*",
            "*/tmp/*",
            "*/lua-language-server/*",
          },
        },
      }
    })
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension('refactoring')
    telescope.load_extension('dap')
    telescope.load_extension("zoxide")
    telescope.load_extension("frecency")
  end,
}

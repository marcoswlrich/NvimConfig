return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        --- #@param colors ColorScheme
        --on_colors = function(colors)
        --end,
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---#@param highlights Highlights
        ---#@param colors ColorScheme
        --on_highlights = function(highlights, colors)
        --end,
      })
      --vim.cmd("colorscheme tokyonight-storm")
      vim.fn.sign_define({
        {
          name = "DiagnosticSignError",
          text = "",
          texthl = "DiagnosticSignError",
          linehl = "ErrorLine",
        },
        {
          name = "DiagnosticSignWarn",
          text = "",
          texthl = "DiagnosticSignWarn",
          linehl = "WarningLine",
        },
        {
          name = "DiagnosticSignInfo",
          text = "",
          texthl = "DiagnosticSignInfo",
          linehl = "InfoLine",
        },
        {
          name = "DiagnosticSignHint",
          text = "",
          texthl = "DiagnosticSignHint",
          linehl = "HintLine",
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    enabled = true,
    priority = 150,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
        color_overrides = {
          mocha = {
            rosewater = "#EA6962",
            flamingo = "#EA6962",
            pink = "#D3869B",
            mauve = "#D3869B",
            red = "#EA6962",
            maroon = "#EA6962",
            peach = "#BD6F3E",
            yellow = "#D8A657",
            green = "#A9B665",
            teal = "#89B482",
            sky = "#89B482",
            sapphire = "#89B482",
            blue = "#7DAEA3",
            lavender = "#7DAEA3",
            text = "#D4BE98",
            subtext1 = "#BDAE8B",
            subtext0 = "#A69372",
            overlay2 = "#8C7A58",
            overlay1 = "#735F3F",
            overlay0 = "#958272",
            surface2 = "#4B4F51",
            surface1 = "#2A2D2E",
            surface0 = "#232728",
            base = "#1D2021",
            mantle = "#191C1D",
            crust = "#151819",
          },
        },
        styles = {
          comments = { "italic" },
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        transparent_background = false,
        show_end_of_buffer = false,
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.crust },
            FloatBorder = { bg = colors.crust, fg = colors.crust },
            VertSplit = { bg = colors.base, fg = colors.surface0 },
            CursorLineNr = { fg = colors.surface2 },
            Pmenu = { bg = colors.crust, fg = "" },
            PmenuSel = { bg = colors.surface0, fg = "" },
            TelescopeSelection = { bg = colors.surface0 },
            TelescopePromptCounter = { fg = colors.mauve },
            TelescopePromptPrefix = { bg = colors.surface0 },
            TelescopePromptNormal = { bg = colors.surface0 },
            TelescopeResultsNormal = { bg = colors.mantle },
            TelescopePreviewNormal = { bg = colors.crust },
            TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
            TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
            TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
            TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
            TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
            TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
            IndentBlanklineChar = { fg = colors.surface0 },
            IndentBlanklineContextChar = { fg = colors.surface2 },
            GitSignsChange = { fg = colors.peach },
            NvimTreeIndentMarker = { link = "IndentBlanklineChar" },
            NvimTreeExecFile = { fg = colors.text },
            IlluminatedWordText = { bg = colors.surface1, fg = "" },
            IlluminatedWordRead = { bg = colors.surface1, fg = "" },
            IlluminatedWordWrite = { bg = colors.surface1, fg = "" },
          }
        end,
      })

      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
  {
    'sainnhe/gruvbox-material',
    enabled = true,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.g.gruvbox_material_background = "hard"
      --vim.g.gruvbox_material_transparent_background = 1
      --vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      --vim.cmd.colorscheme("night-owl")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        overrides = function(colors)
          local theme = colors.theme
          return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none"
              }
            }
          }
        }
      })
      --vim.cmd("colorscheme kanagawa-wave")
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = "auto",
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = "moon",
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
          background = "base",
          background_nc = "_experimental_nc",
          panel = "surface",
          panel_nc = "base",
          border = "highlight_med",
          comment = "muted",
          link = "iris",
          punctuation = "subtle",

          error = "love",
          hint = "iris",
          info = "foam",
          warn = "gold",

          headings = {
            h1 = "iris",
            h2 = "foam",
            h3 = "rose",
            h4 = "gold",
            h5 = "pine",
            h6 = "foam",
          },
          -- or set all headings at once
          -- headings = 'subtle'
        },

        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
          ColorColumn = { bg = "rose" },

          -- Blend colours against the "base" background
          CursorLine = { bg = "foam", blend = 10 },
          StatusLine = { fg = "love", bg = "love", blend = 10 },
        },
      })
      --vim.cmd("colorscheme rose-pine")
    end
  },
}

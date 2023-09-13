return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  config = function()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end

    local setup = {
      plugins = {
        marks = true,       -- shows a list of your marks on ' and `
        registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = false,      -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true,       -- default bindings on <c-w>
          nav = true,           -- misc bindings to work with windows
          z = false,            -- bindings for folds, spelling and others prefixed with z
          g = true,             -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      -- operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        ["<leader>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+",      -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
      },
      window = {
        border = "rounded",       -- none, single, double, shadow
        position = "bottom",      -- bottom, top
        margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },                                             -- min and max height of the columns
        width = { min = 20, max = 50 },                                             -- min and max width of the columns
        spacing = 3,                                                                -- spacing between columns
        align = "center",                                                           -- align columns left, center or right
      },
      ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = false,                                                            -- show help message on the command line when the popup is visible
      -- triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }

    local opts = {
      mode = "n",     -- NORMAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }

    local mappings = {
      -- ["1"] = "which_key_ignore",
      ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
      [";"] = { ":Alpha<CR>", "Dashboard" },
      a = "Swap next param",
      A = "Swap previous param",
      b = {
        name = "Buffers",
        f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
        W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
      },
      c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
      d = {
        name = "Debug",
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
        r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
        x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
      },
      e = { "<cmd>Neotree toggle float<cr>", "File Explorer" },
      f = {
        name = "Find",
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        p = { "<cmd>Telescope treesitter<CR>", "List Symbols" },
        g = { "<cmd>lua require('core.utils').telescope_git_or_file()<CR>", "Find Files" },
        G = { "<cmd>Telescope git_commits<cr>", "Git commits" },
        A = { "<cmd>Telescope git_status<cr>", "Git status" },
        S = { "<cmd>Telescope git_stash<cr>", "Git stash" },
        t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        T = { "<cmd>Telescope grep_string<cr>", "Grep String" },
        s = { "<cmd>Telescope grep_string<cr>", "Find String" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope highlights<cr>", "Highlights" },
        l = { "<cmd>Telescope resume<cr>", "Last Search" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        C = { "<cmd>Telescope commands<cr>", "Commands" },
        z = { "<cmd>Telescope zoxide list<cr>", "Zoxide" },
        e = { "<cmd>Telescope frecency<cr>", "Frecency" },
        B = { "<cmd>Telescope buffers<cr>", "Buffers" },
        d = {
          name = "+DAP",
          c = { "<cmd>Telescope dap commands<cr>", "Dap Commands" },
          b = { "<cmd>Telescope dap list_breakpoints<cr>", "Dap Breakpoints" },
          g = { "<cmd>Telescope dap configurations<cr>", "Dap Configurations" },
          v = { "<cmd>Telescope dap variables<cr>", "Dap Variables" },
          f = { "<cmd>Telescope dap frames<cr>", "Dap Frames" },
        }
      },
      g = {
        name = "Git",
        g = { "<cmd>Neogit<cr>", "Neogit" },
        j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
        k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        l = { "<cmd>GitBlameToggle<cr>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        u = {
          "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
          "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
          "<cmd>Gitsigns diffthis HEAD<cr>",
          "Diff",
        },
      },
      h = { "<cmd>split<cr>", "split" },
      -- k = {}
      l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        A = { "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Range Code Actions" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
        o = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
        R = { "<cmd>Telescope lsp_references<cr>", "References" },
        s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display Signature Information" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename all references" },
        f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
        K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
        l = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics (Trouble)" },
        L = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics (Trouble)" },
        w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        t = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },

        h = { "<cmd>lua require('config.utils').toggle_inlay_hints()<CR>", "Toggle Inlay Hints" },
      },
      m = {
        name = "Markdown",
        m = { "<cmd>MarkdownPreviewToggle<CR>", "markdown preview" },
      },
      -- n =
      -- o =
      p = {
        name = "Python",
        c = { "<cmd>PyrightOrganizeImports<cr>", "Organize Imports" },
        i = { "<cmd>lua require('dap-python').test_class()<CR>", "Debug Class" },
        s = { "<cmd>lua require('dap-python').test_method()<CR>", "Debug Method" },
        S = { "<cmd>lua require('dap-python').debug_selection()<CR>", "Debug Selection" },
      },
      q = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
      r = {
        name = "Glance",
        d = { "<cmd>Glance definitions<cr>", "Definitions" },
        r = { "<cmd>Glance references<cr>", "References" },
        y = { "<cmd>Glance type_definitions<cr>", "Type Definitions" },
        m = { "<cmd>Glance implementations<cr>", "Implementations" },
      },
      s = {
        name = "Session",
        s = { "<cmd>SaveSession<cr>", "Save" },
        r = { "<cmd>RestoreSession<cr>", "Restore" },
        x = { "<cmd>DeleteSession<cr>", "Delete" },
        f = { "<cmd>Autosession search<cr>", "Find" },
        d = { "<cmd>Autosession delete<cr>", "Find Delete" },
        -- a = { ":SaveSession<cr>", "test" },
        -- a = { ":RestoreSession<cr>", "test" },
        -- a = { ":RestoreSessionFromFile<cr>", "test" },
        -- a = { ":DeleteSession<cr>", "test" },
      },
      S = {
        name = "Surround",
        ["."] = { "<cmd>lua require('surround').repeat_last()<cr>", "Repeat" },
        a = { "<cmd>lua require('surround').surround_add(true)<cr>", "Add" },
        d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" },
        r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" },
        q = { "<cmd>lua require('surround').toggle_quotes()<cr>", "Quotes" },
        b = { "<cmd>lua require('surround').toggle_brackets()<cr>", "Brackets" },
      },
      t = {
        name = "Terminal",
        ["1"] = { ":1ToggleTerm<cr>", "1" },
        ["2"] = { ":2ToggleTerm<cr>", "2" },
        ["3"] = { ":3ToggleTerm<cr>", "3" },
        ["4"] = { ":4ToggleTerm<cr>", "4" },
        n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
        t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
        p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm direction=vertical size=100 <cr>", "Vertical" },
      },
      T = {
        name = "+Todo",
        t = { "<cmd>TodoTelescope<cr>", "todo" },
        T = { "<cmd>TodoTelescope keywords=TODO,FIX,NOTE<cr>", "Todo/Fix/Note" },
        x = { "<cmd>TodoTrouble<cr>", "Todo (Trouble)" },
        X = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr><cr>", "Todo/Fix/Fixme (Trouble)" },
      },
      -- u =
      v = { "<cmd>vsplit<cr>", "vsplit" },
      w = { "<cmd>w<CR>", "Write" },
      --x =
      y = {
        name = "Yarn",
        c = { '<cmd>lua require("package-info").change_version()<CR>', "change version" },
        d = { '<cmd>lua require("package-info").delete()<CR>', "delete package" },
        h = { "<cmd>lua require('package-info').hide()<CR>", "hide" },
        i = { '<cmd>lua require("package-info").install()<CR>', "install new package" },
        r = { '<cmd>lua require("package-info").reinstall()<CR>', "reinstall dependencies" },
        s = { '<cmd>lua require("package-info").show()<CR>', "show" },
        u = { '<cmd>lua require("package-info").update()<CR>', "update package" },
      },
      z = {
        name = "Zen",
        z = { "<cmd>TZAtaraxis<cr>", "Zen" },
        m = { "<cmd>TZMinimalist<cr>", "Minimal" },
        n = { "<cmd>TZNarrow<cr>", "Narrow" },
        f = { "<cmd>TZFocus<cr>", "Focus" },
      },

    }

    local vopts = {
      mode = "v",     -- VISUAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }
    local vmappings = {
      ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', "Comment" },
      s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
      -- z = { "<cmd>TZNarrow<cr>", "Narrow" },
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
    which_key.register(vmappings, vopts)
  end
}

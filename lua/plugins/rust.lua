return {
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "rs" },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<Leader>k", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>na", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
        tools = {
          executor = require("rust-tools.executors").termopen,
          autoSetHints = true,
          runnables = {
            use_telescope = true,
          },
          reload_workspace_from_cargo_toml = true,
          on_initialized = function()
            vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
          end,
          inlay_hints = {
            auto = false,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            max_width = nil,
            max_height = nil,
            auto_focus = true,
          },
          crate_graph = {
            backend = "x11",
            output = nil,
            full = true,
            enabled_graphviz_backends = {
              "bmp",
              "cgimage",
              "canon",
              "dot",
              "gv",
              "xdot",
              "xdot1.2",
              "xdot1.4",
              "eps",
              "exr",
              "fig",
              "gd",
              "gd2",
              "gif",
              "gtk",
              "ico",
              "cmap",
              "ismap",
              "imap",
              "cmapx",
              "imap_np",
              "cmapx_np",
              "jpg",
              "jpeg",
              "jpe",
              "jp2",
              "json",
              "json0",
              "dot_json",
              "xdot_json",
              "pdf",
              "pic",
              "pct",
              "pict",
              "plain",
              "plain-ext",
              "png",
              "pov",
              "ps",
              "ps2",
              "psd",
              "sgi",
              "svg",
              "svgz",
              "tga",
              "tiff",
              "tif",
              "tk",
              "vml",
              "vmlz",
              "wbmp",
              "webp",
              "xlib",
              "x11",
            },
          },
        },
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      })
    end
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}

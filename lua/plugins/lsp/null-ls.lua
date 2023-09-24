return {
  "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local status, null_ls = pcall(require, "null-ls")
    if not status then
      return
    end

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    local lsp_formatting = function(bufnr)
      vim.lsp.buf.format({
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      })
    end

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        --null_ls.builtins.diagnostics.eslint_d.with({
        --diagnostics_format = "[eslint] #{m}\n(#{c})",
        --}),
        null_ls.builtins.diagnostics.fish,
        --null_ls.builtins.diagnostics.pylint.with({
        --diagnostics_postprocess = function(diagnostic)
        --diagnostic.code = diagnostic.message_id
        --end,
        --}),
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.clang_format,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              lsp_formatting(bufnr)
            end,
          })
        end
      end,
    })

    vim.api.nvim_create_user_command("DisableLspFormatting", function()
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end, { nargs = 0 })
  end,
}

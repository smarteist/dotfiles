cfg = {}

-- Langs
cfg.ft = {
   "go",
   "c",
   "python",
   "lua",
   "java",
   "javascript",
   "typescript",
   "typescriptreact",
   "javascriptreact",
}

-- Options
cfg.opts = function(null_ls, augroup)
return {
   sources = {
      -- Set a formatter
      null_ls.builtins.formatting.stylua.with({
         extra_args = { '--indent-type', 'spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
      }),

      -- html/css/js/ts/json/yaml/xml/markdown
      null_ls.builtins.formatting.prettier,

      -- go
      -- null_ls.builtins.formatting.gofumpt,
      -- null_ls.builtins.formatting.goimports,
      -- null_ls.builtins.diagnostics.golangci_lint,
      -- null_ls.builtins.code_actions.impl,

      -- java
      null_ls.builtins.formatting.google_java_format,

      -- python
      null_ls.builtins.formatting.black,

      -- c/c++
      null_ls.builtins.formatting.clang_format.with({ filetypes = { 'c', 'cpp', 'proto' } }),

      -- rust
      null_ls.builtins.formatting.rustfmt,

      -- bash
      null_ls.builtins.formatting.shfmt.with {
      	args = { "-i", "2" },
      },
   },
   on_attach = function(client, bufnr)
   if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
         group = augroup,
         buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = augroup,
         buffer = bufnr,
         callback = function()
         vim.lsp.buf.format({ bufnr = bufnr })
         end,
      })
   end
   end,
}
end


return cfg

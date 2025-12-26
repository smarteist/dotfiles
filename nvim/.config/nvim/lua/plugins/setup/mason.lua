return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  lazy = false,
  opts = {
    integrations = {
      ['mason-lspconfig'] = true,
      ['mason-null-ls'] = true,
      ['mason-nvim-dap'] = true,
    },
    run_on_start = true,
    start_delay = 4000,
    ensure_installed = {
      -- Lua
      'lua-language-server',
      'stylua',
      -- Web
      'css-lsp',
      'html-lsp',
      'typescript-language-server',
      'prettier',
      'prettierd',
      'emmet-ls',
      -- Java
      'jdtls',
      'java-test',
      'google-java-format',
      -- C/C++ Tools
      'clangd',
      'clang-format',
      -- Rust
      'rustywind',
      -- Bash
      'shellcheck',
      { 'bash-language-server', auto_update = true },
      'shfmt',
      -- PHP
      'phpactor',
      'php-debug-adapter',
      'php-cs-fixer',
      -- Python
      'pyright',
      'flake8',
      'black',
      'debugpy',
      'mypy',
      'pydocstyle',
      'pylint',
      'pyre',
      'autoflake',
      'autopep8',
      'python-lsp-server',
    },
  },
}

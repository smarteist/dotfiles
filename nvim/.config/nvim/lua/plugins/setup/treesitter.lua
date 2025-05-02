return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'css',
      'go',
      'gomod',
      'gosum',
      'html',
      'java',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'markdown_inline',
      'markdown',
      'php',
      'python',
      'rust',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      -- disable = { "python" }, -- Uncomment if needed
    },
  },
}

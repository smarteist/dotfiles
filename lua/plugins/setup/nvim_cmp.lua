return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'zbirenbaum/copilot-cmp',
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- Snippet source for nvim-cmp
    'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-nvim-lua', -- Lua source for nvim-cmp
    'hrsh7th/cmp-path', -- Path source for nvim-cmp
    'hrsh7th/cmp-cmdline', -- Cmdline source for nvim-cmp
    'hrsh7th/cmp-nvim-lsp-signature-help', -- Optional: LSP signature help
    'onsails/lspkind.nvim', -- VSCode-like pictograms
  },
  opts = {
    sources = {
      { name = 'nvim_lsp', group_index = 2 },
      { name = 'copilot', group_index = 2 },
      { name = 'luasnip', group_index = 2 },
      { name = 'buffer', group_index = 2 },
      { name = 'nvim_lua', group_index = 2 },
      { name = 'path', group_index = 2 },
    },
  },
  config = function()
    require('copilot_cmp').setup()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')

    -- Load friendly-snippets or your preferred snippet collection
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Setup nvim-cmp
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `LuaSnip` users
        end,
      },
      formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          maxwidth = 50,
          ellipsis_char = '...',
        }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For LuaSnip users
        { name = 'buffer' },
        { name = 'path' },
      }),
      experimental = {
        ghost_text = true,
        native_menu = false,
      },
    })

    -- Setup cmdline completion for search and command mode
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}

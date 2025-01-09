return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'zbirenbaum/copilot-cmp',
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
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
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })
  end,
}

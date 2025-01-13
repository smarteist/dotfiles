-- ~/.config/nvim/lua/custom/plugins.lua

return {
  {
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
      -- Setup Copilot-CMP integration
      require('copilot_cmp').setup()

      -- Require necessary modules
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local lspkind = require('lspkind')

      -- Load friendly-snippets or your preferred snippet collection
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Define key mappings for nvim-cmp
      local mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
        ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Scroll documentation down
        ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
        ['<C-e>'] = cmp.mapping.abort(),         -- Abort completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection

        -- Navigate through completion items and snippets
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })

      -- Setup nvim-cmp
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `LuaSnip` users
          end,
        },
        mapping = mapping,
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'copilot' },
          { name = 'luasnip' }, -- For LuaSnip users
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'path' },
        }),
        experimental = {
          ghost_text = true,
          native_menu = false,
        },
      })

      -- Setup cmdline completion for search ('/') and command mode (':')
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
  },
}

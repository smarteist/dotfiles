return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        -- Other configuration options
        defaults = {
            -- Define key mappings
            ['<C-h>'] = { '<cmd>TmuxNavigateLeft<CR>', 'Window Left' },
            ['<C-j>'] = { '<cmd>TmuxNavigateDown<CR>', 'Window Down' },
            ['<C-k>'] = { '<cmd>TmuxNavigateUp<CR>', 'Window Up' },
            ['<C-l>'] = { '<cmd>TmuxNavigateRight<CR>', 'Window Right' },
            -- Add more keybindings here
        },
    },
}

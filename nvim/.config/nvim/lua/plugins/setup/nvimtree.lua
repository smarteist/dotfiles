return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- Optional, for file icons
    },
    opts = {
        -- git support in nvimtree
        git = {
            enable = true,
        },
        filters = {
            dotfiles = false,
        },
        renderer = {
            highlight_git = true,
            icons = {
                show = {
                    git = true,
                },
            },
        },
    },
}

return {
    'NvChad/base46',
    branch = 'v2.5',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
    },
    build = function()
        require('base46').load_all_highlights()
    end,
}

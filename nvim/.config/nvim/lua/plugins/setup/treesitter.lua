-- Define languages as a constant for easy reuse
local LANGUAGES = {
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
}

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
        ensure_installed = LANGUAGES,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    },
    config = function(_, opts)
        -- Set installation preference
        require('nvim-treesitter.install').prefer_git = true

        -- Safety wrapper for v1.0.0+ migration
        local ok, configs = pcall(require, 'nvim-treesitter.configs')
        if ok then
            configs.setup(opts)
        else
            -- Modern Nvim 0.11+ uses native treesitter start
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end
    end,
}

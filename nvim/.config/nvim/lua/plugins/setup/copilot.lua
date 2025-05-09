return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
        -- Possible configurable fields can be found on:
        -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
        suggestion = {
            enable = false,
        },
        panel = {
            enable = false,
        },
        filetypes = {
            markdown = true,
            go = true,
            javascript = true,
            typescript = true,
            yaml = true,
        },
    },
}

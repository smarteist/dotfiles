---@type NvPluginSpec[]
local plugins = {
    require('plugins.setup.autoclose'),
    require('plugins.setup.base46'),
    require('plugins.setup.colorizer'),
    require('plugins.setup.conform'),
    require('plugins.setup.dap_ui'),
    require('plugins.setup.dapconfig'),
    require('plugins.setup.lspconfig'),
    require('plugins.setup.mason'),
    require('plugins.setup.none_ls'),
    require('plugins.setup.nvim_cmp'),
    require('plugins.setup.nvimtree'),
    require('plugins.setup.treesitter'),
    require('plugins.setup.ui'),
    require('plugins.setup.vimwiki'),
    require('plugins.setup.whichkey'),
    require('plugins.setup.copilot'),
}

return plugins

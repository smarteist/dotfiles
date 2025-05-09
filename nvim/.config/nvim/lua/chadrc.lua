-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require('highlights')

-- base-46 color palette theming
M.base46 = {
    theme = 'onedark',
    theme_toggle = { 'onedark', 'one_light' },
    hl_override = highlights.override,
    hl_add = highlights.add,
    tabufline = {
        enable = true,
        lazyload = false,
    },
}

-- nvdash (dashboard)
M.nvdash = {
    load_on_startup = true,

    header = {
        '    _   ___    ________  ___   ____            ___    ___ ',
        '   / | / / |  / /  _/  |/  /  / __ )__  __    /   |  / (_)',
        '  /  |/ /| | / // // /|_/ /  / __  / / / /   / /| | / / / ',
        ' / /|  / | |/ // // /  / /  / /_/ / /_/ /   / ___ |/ / /  ',
        '/_/ |_/  |___/___/_/  /_/  /_____/\\__, /   /_/  |_/_/_/   ',
        '                                 /____/                   ',
    },
}

return M

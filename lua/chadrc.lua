-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require('highlights')

-- base-46 color palette theming
M.base46 = {
  theme = 'gatekeeper',
  theme_toggle = { 'gatekeeper', 'one_light' },
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
    ' _____  ___  ___      ___  __     ___      ___      _______  ___  ___          __      ___        __     ',
    '(\\"   \\|"  \\|"  \\    /"  ||" \\   |"  \\    /"  |    |   _  "\\|"  \\/"  |        /""\\    |"  |      |" \\    ',
    '|.\\\\   \\    |\\   \\  //  / ||  |   \\   \\  //   |    (. |_)  :)\\   \\  /        /    \\   ||  |      ||  |   ',
    "|: \\.   \\\\  | \\\\  \\/. ./  |:  |   /\\\\  \\/.    |    |:     \\/  \\\\  \\/        /' /\\  \\  |:  |      |:  |   ",
    "|.  \\    \\. |  \\.    //   |.  |  |: \\.        |    (|  _  \\\\  /   /        //  __'  \\  \\  |___   |.  |   ",
    '|    \\    \\ |   \\\\   /    /\\  |\\ |.  \\    /:  |    |: |_)  :)/   /        /   /  \\\\  \\( \\_|:  \\  /\\  |\\  ',
    ' \\___|\\____\\)    \\__/    (__\\_|_)|___|\\__/|___|    (_______/|___/        (___/    \\___)\\_______)(__\\_|_) ',
    '                                                                                                         ',
  },
}

return M

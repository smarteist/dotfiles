require('nvchad.options')

-- add yours here!
local o = vim.o
local opt = vim.opt

opt.title = true
opt.hlsearch = true
opt.showcmd = true
opt.scrolloff = 10
opt.inccommand = 'split'
opt.backspace = { 'start', 'eol', 'indent' }
opt.path:append({ '**' })
opt.wildignore:append({ '*/node_modules/*' })
opt.formatoptions:append({ 'r' })

o.shiftwidth = 4
o.expandtab = true
o.softtabstop = 4
o.wrap = true
o.linebreak = true
o.textwidth = 80
o.number = true
o.numberwidth = 2
o.ruler = true

-- terminal general
o.termguicolors = true
o.guicursor = 'i-ci:ver25-blinkwait500-blinkon500-blinkoff500'
o.background = 'dark'
o.signcolumn = 'yes'
o.cursorline = true
o.relativenumber = true
o.colorcolumn = '80'
o.previewheight = 30

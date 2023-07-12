---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme = "onedark",
	theme_toggle = { "onedark", "one_light" },
	hl_override = highlights.override,
	hl_add = highlights.add,
	tabufline = {
		enable = true,
		lazyload = false,
	},
	-- nvdash (dashboard)
	nvdash = {
		load_on_startup = true,

		header = {
		" _____  ___  ___      ___  __     ___      ___      _______  ___  ___          __      ___        __     ",
		"(\\\"   \\|\"  \\|\"  \\    /\"  ||\" \\   |\"  \\    /\"  |    |   _  \"\\|\"  \\/\"  |        /\"\"\\    |\"  |      |\" \\    ",
		"|.\\\\   \\    |\\   \\  //  / ||  |   \\   \\  //   |    (. |_)  :)\\   \\  /        /    \\   ||  |      ||  |   ",
		"|: \\.   \\\\  | \\\\  \\/. ./  |:  |   /\\\\  \\/.    |    |:     \\/  \\\\  \\/        /' /\\  \\  |:  |      |:  |   ",
		"|.  \\    \\. |  \\.    //   |.  |  |: \\.        |    (|  _  \\\\  /   /        //  __'  \\  \\  |___   |.  |   ",
		"|    \\    \\ |   \\\\   /    /\\  |\\ |.  \\    /:  |    |: |_)  :)/   /        /   /  \\\\  \\( \\_|:  \\  /\\  |\\  ",
		" \\___|\\____\\)    \\__/    (__\\_|_)|___|\\__/|___|    (_______/|___/        (___/    \\___)\\_______)(__\\_|_) ",
		"                                                                                                         ",
		},

		buttons = {
		{ "  Find File", "Spc f f", "Telescope find_files" },
		{ "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
		{ "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
		{ "  Bookmarks", "Spc m a", "Telescope marks" },
		{ "  Themes", "Spc t h", "Telescope themes" },
		{ "  Mappings", "Spc c h", "NvCheatsheet" },
		},
	},
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M

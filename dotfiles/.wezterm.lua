local wezterm = require('wezterm')
local config = {}

local window_bell_notified = {} -- Key: window_id, Value: boolean

wezterm.on('window-focus-changed', function(window, pane, has_focus)
    if window then
        local window_id = window:window_id()
        if has_focus then
            window_bell_notified[window_id] = false
        end
    end
end)

wezterm.on('bell', function(window, pane)
    if not window or not pane then
        return
    end

    local window_id = window:window_id()

    if window:is_focused() then
        window_bell_notified[window_id] = false
        return
    end

    if not window_bell_notified[window_id] then
        local pane_title = pane:get_title()
        local user_title = pane:get_user_vars().panetitle

        if user_title and #user_title > 0 then
            pane_title = user_title
        end
        if not pane_title or #pane_title == 0 then
            pane_title = 'Unnamed Pane'
        end

        local notification_title = '🔔 Terminal Bell'
        local notification_message = string.format('Task in Pane: %s', pane_title)

        wezterm.run_child_process({
            'notify-send',
            notification_title,
            notification_message,
            '--icon=utilities-terminal',
            '--app-name=WezTerm',
        })

        window_bell_notified[window_id] = true
    end
end)

wezterm.on('gui-startup', function(cmd)
    local mux = wezterm.mux
    local _, _, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)

config.enable_wayland = true
config.front_end = 'OpenGL'
config.audible_bell = 'Disabled'

config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
    target = 'CursorColor',
}

config.colors = {
    foreground = '#dcdfe4',
    background = '#282c34',
    ansi = {
        '#282c34',
        '#e06c75',
        '#98c379',
        '#e5c07b',
        '#61afef',
        '#c678dd',
        '#56b6c2',
        '#dcdfe4',
    },
    brights = {
        '#3E4451',
        '#E06C75',
        '#98C379',
        '#E5C07B',
        '#61AFEF',
        '#C678DD',
        '#56B6C2',
        '#DCDFE4',
    },
    cursor_bg = '#a3b3cc',
    cursor_border = '#a3b3cc',
    cursor_fg = '#dcdfe4',
    selection_bg = '#474e5d',
    selection_fg = '#dcdfe4',
    visual_bell = '#E9B32A',
}

config.cursor_blink_rate = 150
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.font = wezterm.font('Hack Nerd Font Mono', { weight = 'Regular' })
config.font_size = 10.0
config.bidi_enabled = true
config.bidi_direction = 'LeftToRight'

config.font_rules = {
    {
        intensity = 'Bold',
        font = wezterm.font('Hack Nerd Font Mono', { weight = 'Bold' }),
    },
    {
        italic = true,
        font = wezterm.font('Hack Nerd Font Mono', { italic = true }),
    },
    {
        intensity = 'Bold',
        italic = true,
        font = wezterm.font('Hack Nerd Font Mono', { weight = 'Bold', italic = true }),
    },
}

config.scrollback_lines = 9999
config.default_prog = { '/usr/bin/zsh' }

config.window_padding = {
    left = 3,
    right = 0,
    top = 3,
    bottom = 0,
}
config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 20,
config.window_decorations = 'RESIZE|TITLE'
config.initial_rows = 30
config.initial_cols = 120

config.keys = {
    { key = 'W',        mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = 'S',        mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom('Clipboard') },
    { key = 'T',        mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
    { key = 'N',        mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },
    { key = 'PageUp',   mods = 'SHIFT',      action = wezterm.action.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT',      action = wezterm.action.ScrollByPage(1) },
    { key = 'Home',     mods = 'SHIFT',      action = wezterm.action.ScrollToTop },
    { key = 'End',      mods = 'SHIFT',      action = wezterm.action.ScrollToBottom },
    { key = '=',        mods = 'CTRL|SHIFT', action = wezterm.action.IncreaseFontSize },
    { key = '-',        mods = 'CTRL|SHIFT', action = wezterm.action.DecreaseFontSize },
}

return config

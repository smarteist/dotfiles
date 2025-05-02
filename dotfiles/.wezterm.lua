local wezterm = require('wezterm')

local bell_sent = false
-- Window focus event handler: Resets the bell_sent flag when the window gains focus
wezterm.on('window-focus-changed', function(window, has_focus)
  if has_focus then
    bell_sent = false
  end
end)

wezterm.on('bell', function(window, pane)
  -- Proceed only if the window is NOT focused and a notification hasn't been sent yet
  if not window:is_focused() and not bell_sent then
    -- Retrieve the pane title or user-defined title
    local pane_title = pane:get_title()
    local user_title = pane:get_user_vars().panetitle

    if user_title and #user_title > 0 then
      pane_title = user_title
    end

    local notification_title = '🔔 Terminal Bell'
    local notification_message = string.format('Task: %s', pane_title)

    wezterm.run_child_process({
      'notify-send',
      notification_title,
      notification_message,
      '--icon=utilities-terminal',
    })

    -- Set the flag to prevent further notifications
    bell_sent = true
  end
end)

-- GUI Startup event handler: Maximizes the window on startup
wezterm.on('gui-startup', function(cmd)
  local mux = wezterm.mux
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return {
  -- Uncomment your preferred color scheme
  -- color_scheme = 'OneHalfDark',
  -- color_scheme = 'Neon (terminal.sexy)',
  -- color_scheme = 'Rapture',
  -- color_scheme = 'Cobalt2',
  -- color_scheme = 'Japanesque (Gogh)',
  -- color_scheme = 'Hybrid (Gogh)',

  -- Colors configuration
  colors = {
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
  },

  -- Disable audible bell
  audible_bell = 'Disabled',

  -- Visual bell configuration
  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150,
    target = 'CursorColor',
  },

  -- Cursor configuration
  cursor_blink_rate = 150, -- Blink rate in milliseconds
  default_cursor_style = 'BlinkingBlock', -- Cursor style
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',

  -- Font configuration
  font = wezterm.font('Hack Nerd Font Mono', { weight = 'Regular' }),
  font_size = 10.0,
  bidi_enabled = true,
  bidi_direction = 'LeftToRight',

  -- Font rules for bold and italic text
  font_rules = {
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
  },

  -- Scrollback history
  scrollback_lines = 9999,

  -- Default shell
  default_prog = { '/usr/bin/zsh' },

  -- Window appearance
  window_padding = {
    left = 3,
    right = 0,
    top = 3,
    bottom = 0,
  },
  window_background_opacity = 0.95,
  -- macos_window_background_blur = 20, -- Uncomment if using macOS and want background blur
  window_decorations = 'RESIZE|TITLE', -- Window decorations
  initial_rows = 30, -- Initial number of rows
  initial_cols = 120, -- Initial number of columns

  -- Key bindings
  keys = {
    { key = 'W', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab({ confirm = true }) },
    { key = 'S', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom('Clipboard') },
    { key = 'T', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
    { key = 'N', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnWindow },
    { key = 'PageUp', mods = 'SHIFT', action = wezterm.action.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = wezterm.action.ScrollByPage(1) },
    { key = 'Home', mods = 'SHIFT', action = wezterm.action.ScrollToTop },
    { key = 'End', mods = 'SHIFT', action = wezterm.action.ScrollToBottom },
    { key = '=', mods = 'CTRL|SHIFT', action = wezterm.action.IncreaseFontSize },
    { key = '-', mods = 'CTRL|SHIFT', action = wezterm.action.DecreaseFontSize },
  },
}

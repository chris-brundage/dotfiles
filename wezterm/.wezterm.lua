local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'iTerm2 Pastel Dark Background'

config.cursor_blink_rate = 800
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000
config.pane_focus_follows_mouse = true

-- config.window_background_image = os.getenv('HOME') .. '/Pictures/landscape_extraterrestrial_rocks_130767_3840x2160.jpg'
config.window_background_image = os.getenv('HOME') .. '/Pictures/milky_way_starry_sky_stars_128523_6016x4016.jpg'
config.window_background_image_hsb = {
  brightness = 0.06,
}

config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = 'Ease',
  fade_out_function = 'Ease',
  fade_in_duration_ms = 200,
  fade_out_duration_ms = 300,
  target = 'CursorColor',
}

config.keys = {
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Make option + left arrow jump backwards a word
  {
    key = 'LeftArrow',
    mods = 'META',
    action=wezterm.action{SendString="\x1bb"},
  },
  -- Make option + right arrow jump forwards a word
  {
    key = 'RightArrow',
    mods = 'META',
    action=wezterm.action{SendString="\x1bf"},
  },
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action=wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = 'RightArrow',
    mods = 'CMD',
    action=wezterm.action.ActivateTabRelative(1)
  },
}

return config

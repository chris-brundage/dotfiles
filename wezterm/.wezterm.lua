local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'iTerm2 Pastel Dark Background'

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

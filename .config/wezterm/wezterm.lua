local wezterm = require 'wezterm'

local function recompute_padding(window)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}

  if not window_dims.is_full_screen then
    if not overrides.window_padding then
      -- not changing anything
      return
    end
    overrides.window_padding = nil
  else
    -- Use only the middle 33%
    local new_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    }
    if
      overrides.window_padding
      and new_padding.left == overrides.window_padding.left
    then
      -- padding is same, avoid triggering further changes
      return
    end
    overrides.window_padding = new_padding
  end
  window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window, pane)
  recompute_padding(window)
end)

wezterm.on('window-config-reloaded', function(window)
  recompute_padding(window)
end)

return {
    -- color_scheme = "terafox",
    -- color_scheme = "Tartan (terminal.sexy)",
    -- color_scheme = "TerminixDark (Gogh)",
    -- color_scheme = "Thayer Bright",
    color_scheme = "Tinacious Design (Dark)",
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    tab_bar_at_bottom = true,
    window_padding = {
        left = '1.0cell',
        right = '1.0cell',
        top = '0.5cell',
        bottom = '0.5cell',
    },
}

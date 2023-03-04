local wezterm = require 'wezterm'
local act = wezterm.action
local default_tab_bg = '#0b0022'
local override_bg = '#4b0022'

local keyboard_icon = utf8.char(0xea65)
local terminal_icon = utf8.char(0xf489)

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
        if overrides.window_padding
            and new_padding.left == overrides.window_padding.left
        then
            -- padding is same, avoid triggering further changes
            return
        end
        overrides.window_padding = new_padding
    end
    window:set_config_overrides(overrides)
end

wezterm.on('window-resized', function(window, _pane)
    recompute_padding(window)
end)

wezterm.on('window-config-reloaded', function(window)
    recompute_padding(window)
end)

wezterm.on('update-right-status', function(window, pane)
    local name = ''
    if window:active_key_table() == 'wezterm_unlocked' then
        name = wezterm.format(
            {
                { Foreground = { Color = '#ffffff' } },
                { Background = { Color = override_bg } },
                { Text = ' ' .. terminal_icon .. ' ' .. keyboard_icon .. ' ' },
            })
    end
    window:set_right_status(name)
end)

return {
    font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' }),
    font_size = 14,
    bold_brightens_ansi_colors = true,
    -- disable ligatures
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
    -- color_scheme = "Tinacious Design (Dark)",
    -- color_scheme = "Andromeda",
    -- color_scheme = "Apple Classic", --nightly only
    -- color_scheme = "Atlas (base16)",
    color_scheme = "Atom",
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
    disable_default_key_bindings = true,
    keys = {
        {
            key = 'F12',
            action = act.ActivateKeyTable {
                name = 'wezterm_unlocked',
                one_shot = false,
                replace_current = true,
            }
        },
        {
            key = 'c',
            mods = 'CTRL|SHIFT',
            action = act.CopyTo 'Clipboard',
        },
        {
            key = 'v',
            mods = 'CTRL|SHIFT',
            action = act.PasteFrom 'Clipboard',
        },
    },
    key_tables = {
        wezterm_unlocked = {
            {
                key = 'F12',
                action = 'PopKeyTable'
            },
            {
                key = '|',
                mods = 'CTRL|SHIFT',
                action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
            },
            {
                key = '-',
                mods = 'CTRL|SHIFT',
                action = act.SplitVertical { domain = 'CurrentPaneDomain' },
            },
            {
                key = 'LeftArrow',
                mods = 'CTRL',
                action = act.ActivateTabRelative(-1),
            },
            {
                key = 'RightArrow',
                mods = 'CTRL',
                action = act.ActivateTabRelative(1),
            },
            {
                key = 't',
                mods = 'CTRL',
                action = act.SpawnTab 'CurrentPaneDomain',
            },
            {
                key = 't',
                mods = 'SUPER',
                action = act.SpawnTab 'DefaultDomain',
            },
            {
                key = 'Enter',
                mods = 'ALT',
                action = act.ToggleFullScreen,
            },
            {
                key = '0',
                mods = 'CTRL',
                action = act.ResetFontSize,
            },
            {
                key = '-',
                mods = 'CTRL',
                action = act.DecreaseFontSize,
            },
            {
                key = '=',
                mods = 'CTRL',
                action = act.IncreaseFontSize,
            },
            {
                key = 'n',
                mods = 'CTRL',
                action = act.SpawnWindow,
            },
            {
                key = 'c',
                mods = 'CTRL|SHIFT',
                action = act.CopyTo 'Clipboard',
            },
            {
                key = 'v',
                mods = 'CTRL|SHIFT',
                action = act.PasteFrom 'Clipboard',
            },
            {
                key = 'r',
                mods = 'CTRL|SHIFT',
                action = act.ReloadConfiguration,
            },
            {
                key = 'l',
                mods = 'CTRL|SHIFT',
                action = act.ShowDebugOverlay,
            },
            {
                key = 'Space',
                mods = 'CTRL|SHIFT',
                action = act.QuickSelect,
            },
            {
                key = 'LeftArrow',
                mods = 'ALT',
                action = act.ActivatePaneDirection 'Left',
            },
            {
                key = 'RightArrow',
                mods = 'ALT',
                action = act.ActivatePaneDirection 'Right',
            },
            {
                key = 'UpArrow',
                mods = 'ALT',
                action = act.ActivatePaneDirection 'Up',
            },
            {
                key = 'DownArrow',
                mods = 'ALT',
                action = act.ActivatePaneDirection 'Down',
            },
            {
                key = 'LeftArrow',
                mods = 'ALT|SHIFT',
                action = act.AdjustPaneSize { 'Left', 1 }
            },
            {
                key = 'RightArrow',
                mods = 'ALT|SHIFT',
                action = act.AdjustPaneSize { 'Right', 1 }
            },
            {
                key = 'UpArrow',
                mods = 'ALT|SHIFT',
                action = act.AdjustPaneSize { 'Up', 1 }
            },
            {
                key = 'DownArrow',
                mods = 'ALT|SHIFT',
                action = act.AdjustPaneSize { 'Down', 1 }
            },
            {
                key = 'z',
                mods = 'CTRL|SHIFT',
                action = act.TogglePaneZoomState
            },

        },
    },
    colors = {
        tab_bar = {
            -- The color of the strip that goes along the top of the window
            background = default_tab_bg,
            active_tab = {
                bg_color = '#663399',
                fg_color = '#c0c0c0',
                -- Specify whether you want "Half", "Normal"* or "Bold" intensity
                intensity = 'Bold',
            },
            inactive_tab = {
                bg_color = '#22073d',
                fg_color = '#808080',
            },
            new_tab = {
                bg_color = '#32174d',
                fg_color = '#c0c0c0',
            },
        }
    },
}


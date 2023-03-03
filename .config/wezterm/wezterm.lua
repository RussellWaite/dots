local wezterm = require 'wezterm'
local act = wezterm.action


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

return {
    -- `wezterm ls-fonts --list-system | grep Iosevka | grep Heavy`
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
    keys = {
        {
            key = 'F12',
            action = act.ActivateKeyTable {
                name = 'wezterm_unlocked',
                one_shot = false,
            },
        },
    },
    colors = {
        tab_bar = {
            -- The color of the strip that goes along the top of the window
            background = '#0b0022',
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
    }
}

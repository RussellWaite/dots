----------------------------------------
-- TOKYO NIGHT
----------------------------------------
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "toggleterm", "packer" }
vim.g.tokyonight_terminal_colors = false

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd [[colorscheme tokyonight-night]]



-- make background use terminal's transparent settings
-- vim.cmd[[highlight Normal guibg=none]]
-- vim.cmd[[highlight NonText guibg=none]]


----------------------------------------


----------------------------------------
-- KANAGAWA
----------------------------------------

-- require('kanagawa').setup({
--     compile = false, -- enable compiling the colorscheme
--     undercurl = true, -- enable undercurls
--     commentStyle = { italic = true },
--     functionStyle = {},
--     keywordStyle = { italic = true },
--     statementStyle = { bold = true },
--     typeStyle = {},
--     transparent = false, -- do not set background color
--     dimInactive = false, -- dim inactive window `:h hl-NormalNC`
--     terminalColors = true, -- define vim.g.terminal_color_{0,17}
--     colors = { -- add/modify theme and palette colors
--         palette = {},
--         theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--     },
--     overrides = function(colors) -- add/modify highlights
--         return {}
--     end,
--     theme = "dragon", -- Load "wave" theme when 'background' option is not set
--     background = { -- map the value of 'background' option to a theme
--         dark = "dragon", -- try "dragon" !
--         light = "lotus"
--     },
-- })
--
-- vim.cmd("colorscheme kanagawa-wave")



----------------------------------------

----------------------------------------
-- AYU
----------------------------------------

-- require('ayu').setup({
--     mirage = true, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
--     overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
-- })
--
-- vim.cmd("colorscheme ayu")
----------------------------------------

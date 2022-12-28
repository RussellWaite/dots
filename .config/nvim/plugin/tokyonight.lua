vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "toggleterm", "packer" }
vim.g.tokyonight_terminal_colors = false

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]

-- make background use terminal's transparent settings
vim.cmd[[highlight Normal guibg=none]]
vim.cmd[[highlight NonText guibg=none]]

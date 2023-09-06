vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- replace syntax with treesitter
vim.opt.autoindent = true
vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 300

-- override default loading of netrw, use Telescope instead
-- so disable unused plugins for speed
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.cmd [[
    autocmd! VimEnter * if isdirectory(expand('%:p')) | exe 'cd %:p:h' | exe 'bd!'| exe 'Telescope fd initial_mode=insert' | endif
]]

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

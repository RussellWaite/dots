require("dockeddocs").setup({
    update_mode = "manual",
    position = "right",
})

local sOpts = { silent = true, noremap = true }
-- vim.api.nvim_set_keymap('n', 'gt', '<cmd>DocsViewToggle<cr>', sOpts)
vim.api.nvim_set_keymap('n', '<leader>gh', '<cmd>DocsViewUpdate<cr>', sOpts)

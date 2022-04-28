--keymaps.lua

local map = vim.api.nvim_set_keymap
--local bufmap = vim.api.nvim_buf_set_keymap

vim.g.mapleader = ' '
-- as declared in https://github.com/nanotee/nvim-lua-guide#defining-mappings
-- n normal, v visual select, s select, x visual, i insert, ! insert and command line, 
-- o operator-pending, l insert cmd-line lang-arg?!?, c cmd-line, t terminal
--
local sOpts = {silent = true, noremap= true}

map('n', '<leader>sv', ':source $MYVIMRC<CR>', {noremap = true})

map('n', '<A-j>',      ':m .+1<CR>==', {noremap = true})
map('n', '<A-k>',      ':m .-2<CR>==', {noremap = true})
map('i', '<A-j>',      ':<Esc>:m .+1<CR>==gi', {noremap = true})
map('i', '<A-k>',      ':<Esc>:m .-2<CR>==gi', {noremap = true})
map('v', '<A-j>',      ":m '>+1<CR>gv=gv", {noremap = true})
map('v', '<A-k>',      ":m '<-2<CR>gv=gv", {noremap = true})


map('n', '<leader>t',  ":Telescope<cr>",{})
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>",{})
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>",{})
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>",{})
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>",{})

map("n", "<space>fe",  ":Telescope file_browser<CR>", { noremap = true })

map("n", "<leader>xx", "<cmd>Trouble<cr>", sOpts)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", sOpts)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", sOpts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", sOpts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", sOpts)
map("n", "gR",         "<cmd>Trouble lsp_references<cr>", sOpts)


-- copied from elsewhere

map("n", "<c-]>",      "<cmd>lua vim.lsp.buf.definition()<CR>", sOpts)
map("n", "<c-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>", sOpts)
map("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>", sOpts)
map("n", "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>", sOpts)
map("n", "gc",         "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", sOpts)
map("n", "gd",         "<cmd>lua vim.lsp.buf.type_definition()<CR>", sOpts)
map("n", "gr",         "<cmd>lua vim.lsp.buf.references()<CR>", sOpts)
map("n", "gn",         "<cmd>lua vim.lsp.buf.rename()<CR>", sOpts)
map("n", "gs",         "<cmd>lua vim.lsp.buf.document_symbol()<CR>", sOpts)
map("n", "gw",         "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", sOpts)


-- Replaced LSP implementation with code action plugin...
--
-- nnoremap <silent> ga        "<cmd>lua vim.lsp.buf.code_action()<CR>", sOpts)
--
map("n", "ga",         "<cmd>CodeActionMenu<CR>", sOpts)
map("n", "[x",         "<cmd>lua vim.diagnostic.goto_prev()<CR>", sOpts)
map("n", "]x",         "<cmd>lua vim.diagnostic.goto_next()<CR>", sOpts)
map("n", "]s",         "<cmd>lua vim.diagnostic.show()<CR>", sOpts)


-- Replaced LSP implementation with trouble plugin...
--
-- nnoremap <silent> "<space>q",  "<cmd>lua vim.diagnostic.setloclist()<CR>"
--
--map("n", "<space>q",   "<cmd>Trouble<CR>", sOpts)


local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
  },
})

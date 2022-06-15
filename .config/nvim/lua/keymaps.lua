--keymaps.lua

local map = vim.api.nvim_set_keymap
--local bufmap = vim.api.nvim_buf_set_keymap

vim.g.mapleader = ' '
-- as declared in https://github.com/nanotee/nvim-lua-guide#defining-mappings
-- n normal, v visual select, s select, x visual, i insert, ! insert and command line,
-- o operator-pending, l insert cmd-line lang-arg?!?, c cmd-line, t terminal

local sOpts = {silent = true, noremap= true}

local function describeOptions(desc, options)
    local retVal = {}
    for k,v in pairs(options) do retVal[k] = v end
    retVal["desc"] = desc
    return retVal
end

map('n', '<leader>sv', ':source $MYVIMRC<CR>', {noremap = true})

map('n', '<A-j>',      ':m .+1<CR>==', {noremap = true})
map('n', '<A-k>',      ':m .-2<CR>==', {noremap = true})
map('i', '<A-j>',      ':<Esc>:m .+1<CR>==gi', {noremap = true})
map('i', '<A-k>',      ':<Esc>:m .-2<CR>==gi', {noremap = true})
map('v', '<A-j>',      ":m '>+1<CR>gv=gv", {noremap = true})
map('v', '<A-k>',      ":m '<-2<CR>gv=gv", {noremap = true})

-- Telescope
map('n', '<leader>t',  ":Telescope<cr>",{desc = "Telescope"})
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>",{desc = "Telescope - Find Files"})
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>",{desc = "Telescope - Live Grep"})
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>",{desc = "Telescope - Buffers"})
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>",{desc = "Telescope - Help Tags"})
map("n", "<space>fe",  ":Telescope file_browser<CR>", { noremap = true, desc = "Telescope - File Explorer"})

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>", sOpts)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", sOpts)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", sOpts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", sOpts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", sOpts)
map("n", "gR",         "<cmd>Trouble lsp_references<cr>", sOpts)

-- Completions
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
        require('snippy').expand_snippet(args.body)
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
    { name = 'snippy' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
  },
})

-- Debugging with DAP/rust-tools (when it's working, pfft)

map("n", "<F5>",            "<Cmd>lua require'dap'.continue()<CR>",  sOpts)
map("n", "<F10>",           "<Cmd>lua require'dap'.step_over()<CR>", sOpts)
map("n", "<F11>",           "<Cmd>lua require'dap'.step_into()<CR>", sOpts)
map("n", "<F12>",           "<Cmd>lua require'dap'.step_out()<CR>",  sOpts)
map("n", "<leader>b<F5>",   "<Cmd>lua require'dap'.continue()<CR>",  describeOptions("Continue", sOpts)) -- these are repeated, meant as hints for when whichkey.
map("n", "<leader>b<F10>",  "<Cmd>lua require'dap'.step_over()<CR>", describeOptions("Step Over", sOpts))
map("n", "<leader>b<F11>",  "<Cmd>lua require'dap'.step_into()<CR>", describeOptions("Step Into", sOpts))
map("n", "<leader>b<F12>",  "<Cmd>lua require'dap'.step_out()<CR>",  describeOptions("Step Out", sOpts))
map("n", "<leader>bb",      "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", describeOptions("Toggle Breakpoint", sOpts))
map("n", "<leader>bB",      "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", describeOptions("Conditional Breakpoint", sOpts))
map("n", "<leader>bL",      "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", describeOptions("Log Breakpoint", sOpts))
map("n", "<leader>br",      "<Cmd>lua require'dap'.repl.open()<CR>", describeOptions("REPL", sOpts))
map("n", "<leader>bl",      "<Cmd>lua require'dap'.run_last()<CR>",  describeOptions("Run Last Config", sOpts))
map("n", "<leader>bT",      "<Cmd>lua require'dap'.terminate()<CR>", describeOptions("Terminate", sOpts))
map("n", "<leader>bD",      "<Cmd>lua require'dap'.disconnect()<CR> require'dap'.close()<CR>", describeOptions("Disconnect & Close", sOpts))

map("n", "<leader>bt",      "<Cmd>lua require'dapui'.toggle()<CR>", describeOptions("Toggle UI", sOpts))


-- TODO: THESE LOOK BROKEN - FIX OR DISCARD!

-- Replaced LSP implementation with trouble plugin...
--
-- nnoremap <silent> "<space>q",  "<cmd>lua vim.diagnostic.setloclist()<CR>"
--
--map("n", "<space>q",   "<cmd>Trouble<CR>", sOpts)



-- copied from elsewhere

map("n", "<c-]>",      "<cmd>lua vim.lsp.buf.definition()<CR>", sOpts)
map("n", "<c-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>", sOpts)
map("n", "K",          "<cmd>lua vim.lsp.buf.hover()<CR>", sOpts)
map("n", "<leader>gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>", sOpts)
map("n", "<leader>gc",         "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", sOpts)
map("n", "<leader>gd",         "<cmd>lua vim.lsp.buf.type_definition()<CR>", sOpts)
map("n", "<leader>gr",         "<cmd>lua vim.lsp.buf.references()<CR>", sOpts)
map("n", "<leader>gn",         "<cmd>lua vim.lsp.buf.rename()<CR>", sOpts)
map("n", "<leader>gs",         "<cmd>lua vim.lsp.buf.document_symbol()<CR>", sOpts)
map("n", "<leader>gw",         "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", sOpts)


-- Replaced LSP implementation with code action plugin...
--
-- nnoremap <silent> ga        "<cmd>lua vim.lsp.buf.code_action()<CR>", sOpts)
--
map("n", "<leader>ga",         "<cmd>CodeActionMenu<CR>", sOpts)
map("n", "[x",         "<cmd>lua vim.diagnostic.goto_prev()<CR>", sOpts)
map("n", "]x",         "<cmd>lua vim.diagnostic.goto_next()<CR>", sOpts)
map("n", "]s",         "<cmd>lua vim.diagnostic.show()<CR>", sOpts)


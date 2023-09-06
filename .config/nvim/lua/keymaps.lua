--keymaps.lua

local map = vim.api.nvim_set_keymap
--local bufmap = vim.api.nvim_buf_set_keymap

vim.g.mapleader = ' '
-- as declared in https://github.com/nanotee/nvim-lua-guide#defining-mappings
-- n normal, v visual select, s select, x visual, i insert, ! insert and command line,
-- o operator-pending, l insert cmd-line lang-arg?!?, c cmd-line, t terminal

local sOpts = { silent = true, noremap = true }

local function describeOptions(desc, options)
    local retVal = {}
    for k, v in pairs(options) do retVal[k] = v end
    retVal["desc"] = desc
    return retVal
end

-- prevent me using cusor keys.
-- map('n', '<Up>', '<Nop>', sOpts);
-- map('n', '<Down>', '<Nop>', sOpts);
-- map('n', '<left>', '<Nop>', sOpts);
-- map('n', '<Right>', '<Nop>', sOpts);
map('n', '<Up>', '<cmd>lua print "use hjkl"<cr>', sOpts);
map('n', '<Down>', '<cmd>lua print "use hjkl"<cr>', sOpts);
map('n', '<left>', '<cmd>lua print "use hjkl"<cr>', sOpts);
map('n', '<Right>', '<cmd>lua print "use hjkl"<cr>', sOpts);

map('n', '<space>ss', "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<cr>",
    { desc = "Sourcegraph search" })
map('v', '<space>se', ":CodyExplain<cr>", { desc = "Explain how to use Cody" })
map('v', '<space>sa', ":CodyAsk ", { desc = "Ask a question about the current selection." })
map('n', '<space>sc', ":CodyChat<cr>", { desc = "State a new Cody chat" })
map('n', '<space>st', ":CodyToggle<cr>", { desc = "Toggles Cody chat" })
map('n', '<space>sh', ":CodyHistory<cr>", { desc = "Cody History" })

map('n', '<leader>sv', ':source $MYVIMRC<CR>', { noremap = true })
map('n', '<leader>pd', ':FZF --reverse ~/dev/<CR>', sOpts)
map('n', '<leader>ph', ':FZF --reverse ~/<CR>', sOpts)

map('n', '<A-j>', ':m .+1<CR>==', { noremap = true })
map('n', '<A-k>', ':m .-2<CR>==', { noremap = true })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true })

-- Telescope
map('n', '<leader>t', ":Telescope<cr>", { desc = "Telescope" })
map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "Telescope - Find Files" })
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = "Telescope - Live Grep" })
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", { desc = "Telescope - Buffers" })
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", { desc = "Telescope - Help Tags" })
map("n", "<leader>fe", ":Telescope file_browser<CR>", { noremap = true, desc = "Telescope - File Explorer" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>", sOpts)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", sOpts)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", sOpts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", sOpts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", sOpts)
map("n", "gl", "<cmd>Trouble lsp_references<cr>", sOpts)

-- Completions
local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

local cmp = require('cmp')
cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                snippy = "[Snippy]",
                nvim_lua = "[Lua]",
            })[entry.source.name]
            return vim_item
        end
    },
    mapping = {
        ['<Up>']      = cmp.mapping.select_prev_item(),
        ['<C-p>']     = cmp.mapping.select_prev_item(),
        ['<Down>']    = cmp.mapping.select_next_item(),
        ['<C-n>']     = cmp.mapping.select_next_item(),
        ['<S-Tab>']   = cmp.mapping.select_prev_item(),
        ['<Tab>']     = cmp.mapping.select_next_item(),
        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>']     = cmp.mapping.close(),
        ['<CR>']      = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'snippy' },
        { name = 'path' },
        -- { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Debugging with DAP/rust-tools (when it's working, pfft)

map("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", sOpts)
map("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", sOpts)
map("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", sOpts)
map("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", sOpts)
map("n", "<leader>b<F5>", "<Cmd>lua require'dap'.continue()<CR>", describeOptions("Continue", sOpts)) -- these are repeated, meant as hints for when whichkey.
map("n", "<leader>b<F10>", "<Cmd>lua require'dap'.step_over()<CR>", describeOptions("Step Over", sOpts))
map("n", "<leader>b<F11>", "<Cmd>lua require'dap'.step_into()<CR>", describeOptions("Step Into", sOpts))
map("n", "<leader>b<F12>", "<Cmd>lua require'dap'.step_out()<CR>", describeOptions("Step Out", sOpts))
map("n", "<leader>bb", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", describeOptions("Toggle Breakpoint", sOpts))
map("n", "<leader>bB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    describeOptions("Conditional Breakpoint", sOpts))
map("n", "<leader>bL", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    describeOptions("Log Breakpoint", sOpts))
map("n", "<leader>br", "<Cmd>lua require'dap'.repl.open()<CR>", describeOptions("REPL", sOpts))
map("n", "<leader>bl", "<Cmd>lua require'dap'.run_last()<CR>", describeOptions("Run Last Config", sOpts))
map("n", "<leader>bT", "<Cmd>lua require'dap'.terminate()<CR>", describeOptions("Terminate", sOpts))
map("n", "<leader>bD", "<Cmd>lua require'dap'.disconnect()<CR> require'dap'.close()<CR>",
    describeOptions("Disconnect & Close", sOpts))

map("n", "<leader>bt", "<Cmd>lua require'dapui'.toggle()<CR>", describeOptions("Toggle UI", sOpts))
map("n", "<leader>be", "<Cmd>lua require'dapui'.eval()<CR>", describeOptions("Evaluate under cursor", sOpts))

map("n", "<leader>ggdo", "<Cmd>DiffviewOpen<CR>", describeOptions("Open Diff", sOpts))
map("n", "<leader>ggdc", "<Cmd>DiffviewClose<CR>", describeOptions("Close Diff", sOpts))
map("n", "<leader>ggdh", "<Cmd>DiffviewFileHistory<CR>", describeOptions("File History", sOpts))
map("n", "<leader>ggdf", "<Cmd>DiffviewFocusFiles<CR>", describeOptions("Focus Files", sOpts))
map("n", "<leader>ggdr", "<Cmd>DiffviewRefresh<CR>", describeOptions("Refresh Diff", sOpts))

map("n", "<leader>rf", "<Cmd>lua vim.lsp.buf.format()<CR>", describeOptions("Format Code", sOpts))
-- TODO: THESE LOOK BROKEN - FIX OR DISCARD!

map("n", "<leader>gc", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", sOpts)
map("n", "<leader>gs", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", sOpts)
map("n", "<leader>gw", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", sOpts)

-- Replaced LSP implementation with code action plugin...
map("n", "[x", "<cmd>lua vim.diagnostic.goto_prev()<CR>", sOpts)
map("n", "]x", "<cmd>lua vim.diagnostic.goto_next()<CR>", sOpts)
map("n", "]gs", "<cmd>lua vim.diagnostic.show()<CR>", sOpts)
map("n", "]ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", sOpts)
-- map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", sOpts)
map("n", "<C-Space>", "<cmd>lua vim.lsp.buf.hover()<CR>", sOpts)

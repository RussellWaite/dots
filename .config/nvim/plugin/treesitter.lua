require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "c_sharp",
        "dockerfile",
        "gomod",
        "gowork",
        "http",
        "javascript",
        "lua",
        "make",
        "regex",
        "rust",
        "typescript"
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, },
    indent = { enabled = true, },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    textobjects = {
        select = {
            enabled = true,
            lookahead = true,
            keymaps = {
                ["a="] = { query = "@assignment.outer", desc = "Select outer part of assignment", },
                ["i="] = { query = "@assignment.inner", desc = "Select inner part of assignment", },
                ["l="] = { query = "@assignment.lhs", desc = "Select LHS of assignment", },
                ["r="] = { query = "@assignment.rhs", desc = "Select RHS of assignment", },

                ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-e>",
                node_incremental = "<C-e>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "Next func sig" },
                ["]b"] = { query = "@function.inner", desc = "Next func body" },
                ["]["] = { query = "@class.outer", desc = "Next class decl" },
            },
            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "Next func end" },
                ["]]"] = { query = "@class.outer", desc = "Next class end" },
            },
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "Prev func sig" },
                ["[b"] = { query = "@function.inner", desc = "Prev func body" },
                ["[["] = { query = "@class.outer", desc = "Prev class decl" },
            },
            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "Prev func end" },
                ["[]"] = { query = "@class.outer", desc = "Prev class end" },
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
                ["<leader>gf"] = "@function.outer",
                ["<leader>gF"] = "@class.outer",
            },
        },
    },
}

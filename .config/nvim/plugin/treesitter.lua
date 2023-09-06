require('nvim-treesitter.configs').setup {
    ensure_installed = { "bash", "c", "cmake", "dockerfile", "gomod", "gowork", "http", "make", "regex" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = {
        enabled = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    textobjects = {
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

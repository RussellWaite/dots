-- setup lazy if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    'romgrk/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- could also  'mizlan/iswap.nvim' for swapping items, more options than textobjects
    'nvim-treesitter/playground',
    'neovim/nvim-lspconfig',
    'Hoffs/omnisharp-extended-lsp.nvim',

    -- completion engine
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    --  'hrsh7th/cmp-buffer'
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    'nvim-lua/lsp-status.nvim',

    -- snippets manager
    'dcampos/nvim-snippy',
    -- snippets completion
    'dcampos/cmp-snippy',
    -- snippets source
    'honza/vim-snippets', -- TODO: this needs to be tested as it might be easier to grab the snippets I need into files for snippy and dump this plugin (don't want 500 different language snippets being loaded into memory when I could just  a custo cuatd list and a comment reminding me how to get more for new language X in the future...

    -- terminal
    'akinsho/toggleterm.nvim',

    -- Debugging
    'nvim-lua/plenary.nvim',
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap"
    },
    'simrat39/rust-tools.nvim',
    'nvim-telescope/telescope-dap.nvim',

    'leoluz/nvim-dap-go',

    -- Code hints
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    'folke/which-key.nvim',
    'gpanders/editorconfig.nvim',
    'numToStr/Comment.nvim',

    -- git
    {
        'sindrets/diffview.nvim',
        dependencies = 'nvim-lua/plenary.nvim'
    },
    {
        'TimUntersberger/neogit',
        dependencies = 'nvim-lua/plenary.nvim'
    },
    { -- not tried this yet, has staging of hunk support though too and looks simpler...
        'lewis6991/gitsigns.nvim',
        tag = 'release' -- To  the latest release
    },


    -- Fancy UI stuff
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { { 'nvim-lua/plenary.nvim' } } -- weird syntax, assume I've copied this..?
    },
    'nvim-telescope/telescope-file-browser.nvim', --replace nerdtree
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    'nvim-telescope/telescope-ui-select.nvim',

    'kyazdani42/nvim-web-devicons',
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    },

    { dir = '~/dev/lua/dockeddocs/' },
    {
        dir = '~/dev/lua/rwplugin/',
        config = function()
            require("rwplugin").setup({
                -- leave empty to use defaults
            })
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },

    'folke/tokyonight.nvim',
    'Shatur/neovim-ayu',
    'rebelot/kanagawa.nvim',

    -- AI
    {
        'sourcegraph/sg.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim'
        }
    },

})

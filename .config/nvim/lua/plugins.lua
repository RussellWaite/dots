--vim.cmd [[packadd packer.nvim]] -- not sure if I need this or not, packer's readme could be clearer...

--return -- do we need to return from packer's startup call?
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'romgrk/nvim-treesitter-context'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    -- could also use 'mizlan/iswap.nvim' for swapping items, more options than textobjects
    use 'nvim-treesitter/playground'
    use 'neovim/nvim-lspconfig'
    use 'Hoffs/omnisharp-extended-lsp.nvim'

    -- completion engine
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    use 'nvim-lua/lsp-status.nvim'

    -- snippets manager
    use 'dcampos/nvim-snippy'
    -- snippets completion
    use 'dcampos/cmp-snippy'
    -- snippets source
    use 'honza/vim-snippets' -- TODO: this needs to be tested as it might be easier to grab the snippets I need into files for snippy and dump this plugin (don't want 500 different language snippets being loaded into memory when I could just use a custo cuatd list and a comment reminding me how to get more for new language X in the future...

    -- terminal
    use 'akinsho/toggleterm.nvim'

    -- Debugging
    use 'nvim-lua/plenary.nvim'
    use {
        "rcarriga/nvim-dap-ui",
        requires = "mfussenegger/nvim-dap"
    }
    use 'simrat39/rust-tools.nvim'
    use 'nvim-telescope/telescope-dap.nvim'

    -- Code hints
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
    use 'folke/which-key.nvim'
    use 'gpanders/editorconfig.nvim'
    use 'numToStr/Comment.nvim'

    -- git
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim'
    }
    --use { -- not tried this yet, has staging of hunk support though too and looks simpler...
    --    'lewis6991/gitsigns.nvim',
    --    -- tag = 'release' -- To use the latest release
    --}


    -- Fancy UI stuff
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } } -- weird syntax, assume I've copied this..?
    }
    use 'nvim-telescope/telescope-file-browser.nvim' --replace nerdtree
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use 'nvim-telescope/telescope-ui-select.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }

    -- use '~/.config/nvim/localplugins/dockeddocs'
    use '~/dev/lua/rwplugin/'

    use 'folke/tokyonight.nvim'
    use 'Shatur/neovim-ayu'
    use 'rebelot/kanagawa.nvim'

    -- AI
    use {
        'sourcegraph/sg.nvim',
        run = 'nvim -l build/init.lua',
        requires = {
            'nvim-telescope/telescope.nvim'
        }
    }
end)

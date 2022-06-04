--vim.cmd [[packadd packer.nvim]] -- not sure if I need this or not, packer's readme could be clearer...

--return -- do we need to return from packer's startup call?
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- use 'nvim-lua/popup.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-file-browser.nvim' --replace nerdtree
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use 'nvim-telescope/telescope-ui-select.nvim'

    use 'neovim/nvim-lspconfig'

    -- completion engine
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    -- snippets
    use 'dcampos/nvim-snippy'
    use 'dcampos/cmp-snippy'
    use 'honza/vim-snippets' -- TODO: this needs to be tested as it might be easier to grab the snippets I need into files for snippy and dump this plugin (don't want 500 different language snippets being loaded into memory when I could just use a custo cuatd list and a comment reminding me how to get more for new language X in the future...

    -- terminal
    use 'akinsho/toggleterm.nvim'

    -- Debugging
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use 'simrat39/rust-tools.nvim'
    use 'nvim-telescope/telescope-dap.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use({
        'nvim-lualine/lualine.nvim',
        --config = function() require('plugins.lualine') end,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    use 'folke/which-key.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
    use 'gpanders/editorconfig.nvim'

    use 'folke/tokyonight.nvim'
end)


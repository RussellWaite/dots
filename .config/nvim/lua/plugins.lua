--vim.cmd [[packadd packer.nvim]] -- not sure if I need this or not, packer's readme could be clearer...

--return -- do we need to return from packer's startup call?
require('packer').startup(function()
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

		use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'
    
    -- completion engine
		use 'hrsh7th/nvim-cmp'
		use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

		-- terminal
		use 'akinsho/toggleterm.nvim'

    -- Debugging
    --use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'
    -- status line
		-- statusline
    use({
        'nvim-lualine/lualine.nvim',
        --config = function() require('plugins.lualine') end,
				requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })
		use 'folke/tokyonight.nvim'
		use 'folke/which-key.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
end)


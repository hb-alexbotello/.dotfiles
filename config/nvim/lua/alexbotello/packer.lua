-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Treesitter
  use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- use 'aswathkk/darkscene.vim'
  use "folke/tokyonight.nvim"
  use "EdenEast/nightfox.nvim"
  use "AlexvZyl/nordic.nvim"

  -- Vim Surround
  use 'tpope/vim-surround'

  -- Vim Commentary
  use 'tpope/vim-commentary'

  -- Telescope
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.6',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } 

  -- Harpoon (marks on steroids)
  use {
      'ThePrimeagen/harpoon',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Git
  use "tpope/vim-fugitive"
  use {
      'tanvirtin/vgit.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      }
  }

  use "stevearc/oil.nvim"

  -- File Tree
  -- use {
  --     'kyazdani42/nvim-tree.lua',
  --     requires = {
  --       'kyazdani42/nvim-web-devicons', -- optional, for file icons
  --     },
  --     tag = 'nightly' -- optional, updated every week. (see issue #1193)
  -- }
end)

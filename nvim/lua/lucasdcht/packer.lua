-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  -- Telescope (fuzy finder)

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Colorscheme
  use({
    "ellisonleao/gruvbox.nvim",
    as = "gruvbox",
    config = function()
      vim.cmd("colorscheme gruvbox")
    end
  })

  -- Syntax hightlighting
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })


  -- harpoon <3
  use("theprimeagen/harpoon")


  -- undotree
  use("mbbill/undotree")


  -- fugitive
  use("tpope/vim-fugitive")


  -- lspconfig
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }

  -- discord rich presence
  use 'andweeb/presence.nvim'

  -- formatter
  use { "stevearc/conform.nvim", }

  -- linter
  use 'mfussenegger/nvim-lint'

  -- zenmode
  use "folke/zen-mode.nvim"

  -- status line
  use {
    'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
end)

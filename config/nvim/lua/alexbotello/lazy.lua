-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {'neovim/nvim-lspconfig'},

    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'saadparwaiz1/cmp_luasnip'},

    { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" },

    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

    { 'aswathkk/darkscene.vim'},
    { "EdenEast/nightfox.nvim" },
    { "AlexvZyl/nordic.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "sho-87/kanagawa-paper.nvim" },
    { "zenbones-theme/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },

    { 'tpope/vim-surround' },

    { 'tpope/vim-commentary' },

    {
      'nvim-telescope/telescope.nvim', tag = '0.1.6',
      dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    {
      'ThePrimeagen/harpoon',
      dependencies = { {'nvim-lua/plenary.nvim'} }
    },

    { "tpope/vim-fugitive" },
    {
      'tanvirtin/vgit.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim'
      }
    },

    {"stevearc/oil.nvim"},

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    {
      "greggh/claude-code.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
      },
    }

    -- {
    --   "coder/claudecode.nvim",
    --   dependencies = {
    --     "folke/snacks.nvim", -- Optional for enhanced terminal
    --   },
    --   opts = {
    --     -- Server options
    --     port_range = { min = 10000, max = 65535 },
    --     auto_start = true,
    --     log_level = "info",

    --     -- Terminal options
    --     terminal = {
    --       split_side = "right",
    --       split_width_percentage = 0.3,
    --       provider = "snacks", -- or "native"
    --     },

    --     -- Diff options
    --     diff_opts = {
    --       auto_close_on_accept = true,
    --       vertical_split = true,
    --     },
    --   },
    --   config = true,
    --   keys = {
    --     { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    --     { "<leader>ao", "<cmd>ClaudeCodeOpen<cr>", desc = "Open Claude" },
    --     { "<leader>ax", "<cmd>ClaudeCodeClose<cr>", desc = "Close Claude" },
    --   },
    -- },

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

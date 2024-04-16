local LAZYPATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(LAZYPATH) then
   vim.schedule(function()
      print("Lazy.nvim was not installed, consider running :UserInstallLazy.")
   end)

   return
end

vim.opt.rtp:prepend(LAZYPATH)

local status_ok, lazy = pcall(require, "lazy")

if not status_ok then
   vim.schedule(function()
      print("Error requiring the lazy.nvim module, recheck your config files.")
   end)

   return
end

-- the plugins list should be in the table below + the configuration modules

lazy.setup({
   "kyazdani42/nvim-web-devicons",
   "tpope/vim-surround",
   "andweeb/presence.nvim",

   {
      "shaunsingh/nord.nvim",
      config = function()
         require("plugged.config.nord")
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      config = function()
         require("plugged.config.lualine")
      end,
   },
   {
      "akinsho/bufferline.nvim",
      dependencies = { "tiagovla/scope.nvim" },
      config = function()
         require("plugged.config.bufferline")
      end,
   },
   {
      "lewis6991/gitsigns.nvim",
      config = function()
         require("plugged.config.gitsigns")
      end,
   },
   {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
         require("plugged.config.ibl")
      end,
   },

   {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
         require("plugged.config.telescope")
      end,
   },
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "saadparwaiz1/cmp_luasnip",
      },
      config = function()
         require("plugged.config.cmp")
      end,
   },
   {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
         require("plugged.config.luasnip")
      end,
   },

   {
      "nvim-treesitter/nvim-treesitter",
      config = function()
         require("plugged.config.treesitter")
      end,
   },
   {
      "tpope/vim-commentary",
      config = function()
         require("plugged.config.commentary")
      end,
   },
   {
      "windwp/nvim-autopairs",
      config = function()
         require("plugged.config.autopairs")
      end,
   },

   {
      "williamboman/mason.nvim",
      dependencies = {
         "neovim/nvim-lspconfig",
         "williamboman/mason-lspconfig.nvim",
         "folke/neodev.nvim",
         "j-hui/fidget.nvim",
      },
      config = function()
         require("plugged.config.lspconfig")
      end,
   },
})

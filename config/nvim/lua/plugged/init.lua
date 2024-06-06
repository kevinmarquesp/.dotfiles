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

   "rmehri01/onenord.nvim",
   "nvim-lualine/lualine.nvim",
   "lewis6991/gitsigns.nvim",
   "lukas-reineke/indent-blankline.nvim",
   "nvim-treesitter/nvim-treesitter",
   "tpope/vim-commentary",
   "windwp/nvim-autopairs",

   "tiagovla/scope.nvim",
   "akinsho/bufferline.nvim",

   "rafamadriz/friendly-snippets",
   "L3MON4D3/LuaSnip",

   "nvim-lua/plenary.nvim",
   "nvim-telescope/telescope.nvim",

   "hrsh7th/cmp-nvim-lua",
   "hrsh7th/cmp-nvim-lsp",
   "hrsh7th/cmp-buffer",
   "hrsh7th/cmp-path",
   "hrsh7th/cmp-cmdline",
   "saadparwaiz1/cmp_luasnip",
   "hrsh7th/nvim-cmp",

   "neovim/nvim-lspconfig",
   "williamboman/mason-lspconfig.nvim",
   "folke/neodev.nvim",
   "j-hui/fidget.nvim",
   "williamboman/mason.nvim",
})

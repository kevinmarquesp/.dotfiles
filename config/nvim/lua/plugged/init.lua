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
      dependencies = { "akinsho/bufferline.nvim" },
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
})

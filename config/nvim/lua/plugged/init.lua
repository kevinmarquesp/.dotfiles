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

-- The plugins list should be in the table below

lazy.setup({})

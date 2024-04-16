vim.api.nvim_create_user_command("UserInstallLazy", function()
   local LAZYPATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

   if not vim.loop.fs_stat(LAZYPATH) then
      vim.schedule(function()
         print("Installing the latest stable version of lazy.nvim.")
      end)

      vim.fn.system({
         "git",
         "clone",
         "--filter=blob:none",
         "https://github.com/folke/lazy.nvim.git",
         "--branch=stable", -- latest stable release
         LAZYPATH,
      })
   end
end, {})

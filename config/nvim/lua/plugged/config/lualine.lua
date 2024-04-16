local status_ok, lualine = pcall(require, "lualine")

if not status_ok then
   vim.schedule(function()
      print("Error requiring lualine plugin.")
   end)

   return
end

lualine.setup()

local status_ok, autopairs = pcall(require, "nvim-autopairs")

if not status_ok then
   vim.schedule(function()
      print("Error requiring autopairs plugin.")
   end)

   return
end

autopairs.setup()

local status_ok, ibl = pcall(require, "ibl")

if not status_ok then
   vim.schedule(function()
      print("Error requiring indent-blankline plugin.")
   end)

   return
end

ibl.setup()

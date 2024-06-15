local status_ok, gitsigns = pcall(require, "gitsigns")

if not status_ok then
   vim.schedule(function()
      print("Error requiring gitsigns plugin.")
   end)

   return
end

gitsigns.setup({
   current_line_blame = true,
})

local status_ok, onenord = pcall(require, "onenord")

if not status_ok then
   vim.schedule(function()
      print("Error requiring the nord.nvim plugin.")
   end)

   return
end

onenord.setup()

-- The terminal window is too light for my taste, this line fix that.

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

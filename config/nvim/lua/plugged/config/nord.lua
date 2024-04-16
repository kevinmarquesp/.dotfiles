local status_ok, nord = pcall(require, "nord")

if not status_ok then
   vim.schedule(function()
      print("Error requiring the nord.nvim plugin.")
   end)

   return
end

nord.set()

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

vim.cmd("colorscheme nord")

-- The terminal window is too light for my taste, this line fix that.

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

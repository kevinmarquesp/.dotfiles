-- Will use the Neovim LSP capabilities to format the file before saving.

vim.api.nvim_create_autocmd("BufWrite", {
   pattern = "*",

   callback = function(_event)
      vim.lsp.buf.format()
   end,
})

-- Start the correct LSP automatically when enter because... Gotta go fast!

vim.api.nvim_create_autocmd("BufEnter", {
   pattern = "*",

   callback = function(_)
      vim.cmd("LspStart")
   end,
})

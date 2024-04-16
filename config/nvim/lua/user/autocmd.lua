-- Will use the Neovim LSP capabillyties to format the file before saving.

vim.api.nvim_create_autocmd("BufWrite", {
   pattern = "*",

   callback = function(_)
      vim.lsp.buf.format()
   end
})

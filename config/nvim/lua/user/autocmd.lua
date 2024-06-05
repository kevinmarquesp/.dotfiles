-- Will use the Neovim LSP capabilities to format the file before saving.

vim.api.nvim_create_autocmd("BufWrite", {
   pattern = "*",

   callback = function(ev)
      local EXCLUDE_MATCH = ".*(html|edge)$"

      if nil == string.match(ev.file, EXCLUDE_MATCH) then
         return
      end

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

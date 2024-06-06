function get_extension(filename)
   local parts = {}

   for w in filename:gmatch("([^.]+)") do
      table.insert(parts, w)
   end

   return table.concat(parts, ".", 2)
end

function contains(table, element)
   for _, value in pairs(table) do
      if value == element then
         return true
      end
   end

   return false
end

-- Will use the Neovim LSP capabilities to format the file before saving.

vim.api.nvim_create_autocmd("BufWrite", {
   pattern = "*",

   callback = function(event)
      local extension = get_extension(event.file)

      if contains({ "html", "edge" }, extension) then
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

local status_ok, luasnip_vscode_loader = pcall(require, "luasnip.loaders.from_vscode")

if not status_ok then
   vim.schedule(function()
      print("Error requiring luasnip.loaders.from_vscode plugin module.")
   end)

   return
end

luasnip_vscode_loader.load()

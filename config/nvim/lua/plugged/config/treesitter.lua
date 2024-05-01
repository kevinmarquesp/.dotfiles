local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")

if not status_ok then
   vim.schedule(function()
      print("Error requiring nvim-treesitter.configs plugin module.")
   end)

   return
end

treesitter.setup({
   sync_install = true,

   ensure_installed = { "lua", "vim", "bash", "python", "elixir", "javascript",
      "typescript", "c", "cpp", "go" },

   highlight = {
      enable = true,
      disable = { "html", "vim", "vue" },
      additional_vim_regex_highlighting = true,
   },

   indent = {
      enable = true,
      disable = { "scss", "css", "sass" },
   },
})

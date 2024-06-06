local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")

if not status_ok then
   vim.schedule(function()
      print("Error requiring mason-lspconfig plugin.")
   end)

   return
end

local mason

status_ok, mason = pcall(require, "mason")

if not status_ok then
   vim.schedule(function()
      print("Error requiring mason plugin.")
   end)

   return
end

local neodev

status_ok, neodev = pcall(require, "neodev")

if not status_ok then
   vim.schedule(function()
      print("Error requiring neodev plugin.")
   end)

   return
end

local fidget

status_ok, fidget = pcall(require, "fidget")

if not status_ok then
   vim.schedule(function()
      print("Error requiring fidget plugin.")
   end)

   return
end

local cmp_lsp

status_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
   vim.schedule(function()
      print("Error requiring cmp_nvim_lsp plugin module.")
   end)

   return
end

local lspconfig

status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then
   vim.schedule(function()
      print("Error requiring lspconfig plugin.")
   end)

   return
end

-- the real config section starts here

vim.filetype.add({ extension = { templ = 'templ' } })

mason.setup()
neodev.setup()
fidget.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.default_capabilities(capabilities)

local servers = {
   elixirls = {
      capabilities = capabilities,
      settings = {
         elixirLS = {
            dialyzerEnabled = false,
         },
      },
   },
   emmet_ls = {
      capabilities = capabilities,
      filetypes = { "html", "templ", "javascript", "typescript", "typescriptreact", "javascriptreact" },
   },
   html = {
      on_attach = function(client, _)
         client.server_capabilities.documentFormattingProvider = false
         client.server_capabilities.documentRangeFormattingProvider = false
      end,

      capabilities = capabilities,
   }
}

mason_lspconfig.setup({
   ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
   function(server_name)
      local server = servers[server_name] or {}

      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      lspconfig[server_name].setup(server)
   end,
})

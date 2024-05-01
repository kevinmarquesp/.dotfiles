local status_ok, bufferline = pcall(require, "bufferline")

if not status_ok then
   vim.schedule(function()
      print("Error requiring bufferline plugin.")
   end)

   return
end

-- this plugins allows me to have different groups of buffers into different tabs

local scope

status_ok, scope = pcall(require, "scope")

if not status_ok then
   vim.schedule(function()
      print("Error requiring scope plugin.")
   end)

   return
end

bufferline.setup()
scope.setup()

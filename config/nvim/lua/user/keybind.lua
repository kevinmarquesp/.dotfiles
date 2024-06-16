local opts = { remap = false }
local map = vim.keymap.set

map("n", "<cr>", ":Commentary<cr>")
map("v", "<cr>", ":'<'>Commentary<cr>")

map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "K", vim.lsp.buf.hover, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "<leader>vca", vim.lsp.buf.code_action, opts)
map("n", "<leader><f3>", vim.lsp.buf.references, opts)
map("n", "<leader><f2>", vim.lsp.buf.rename, opts)
map("n", "<leader>d", vim.lsp.buf.workspace_symbol, opts)
map("n", "<c-k>", vim.diagnostic.open_float, opts)
map("n", "<leader>L", ":LspStart<cr>", opts)
map("n", "<leader>S", ":LspStop<cr>", opts)

local status_ok, telescope_builtin = pcall(require, "telescope.builtin")

if not status_ok then
   vim.schedule(function()
      print("Cannot configure Telescope bindings, error when requiring.")
   end)
else
   map("n", "<c-p>", telescope_builtin.find_files)
   map("n", "<leader>p", telescope_builtin.buffers)
   map("n", "<leader>r", telescope_builtin.lsp_references)
   map("n", "<leader>fc", telescope_builtin.git_commits)
   map("n", "<leader>fs", telescope_builtin.git_status)
   map("n", "<leader>fm", telescope_builtin.marks)
   map("n", "<leader>?", telescope_builtin.keymaps)
end

local gitsigns
status_ok, gitsigns = pcall(require, "gitsigns")

if not status_ok then
   vim.schedule(function()
      print("Cannot configure Gitsigns bindings, error when requiring.")
   end)
else
   map("v", "<leader>ga", gitsigns.stage_hunk)
   map("v", "<leader>gr", gitsigns.reset_hunk)
   map("n", "<leader>ga", gitsigns.stage_hunk)
   map("n", "<leader>gA", gitsigns.stage_buffer)
   map("n", "<leader>gr", gitsigns.reset_hunk)
   map("n", "<leader>gu", gitsigns.undo_stage_hunk)
   map("n", "<leader>gp", gitsigns.preview_hunk)
   map("n", "<leader>gP", gitsigns.preview_hunk_inline)
end

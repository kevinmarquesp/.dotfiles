local status_ok, actions = pcall(require, "telescope.actions")

if not status_ok then
   vim.schedule(function()
      print("Error requiring telescope.actions plugin module.")
   end)

   return
end

local action_state

status_ok, action_state = pcall(require, "telescope.actions.state")

if not status_ok then
   vim.schedule(function()
      print("Error requiring telescope.actions.state plugin module.")
   end)

   return
end

local sorters

status_ok, sorters = pcall(require, "telescope.sorters")

if not status_ok then
   vim.schedule(function()
      print("Error requiring telescope.sorters plugin module.")
   end)

   return
end

local previewers

status_ok, previewers = pcall(require, "telescope.previewers")

if not status_ok then
   vim.schedule(function()
      print("Error requiring telescope.previewers plugin module.")
   end)

   return
end

require("telescope").setup({
   defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",

      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",

      file_sorter = sorters.get_fuzzy_file,
      generic_sorter = sorters.get_generic_fuzzy_sorter,

      file_ignore_patterns = { "node_modules" },
      path_display = { "truncate" },

      color_devicons = true,
      use_less = true,

      set_env = { ["COLORTERM"] = "truecolor" },
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

      buffer_previewer_maker = previewers.buffer_previewer_maker,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      file_previewer = previewers.vim_buffer_cat.new,

      mappings = {
         i = {
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-l>"] = actions.close,
            ["<c-p>"] = actions.close,
            ["<cr>"] = function(prompt_bufnr) -- HOTFIX: Custom action to apply my custom fonding config.
               local selection = action_state.get_selected_entry()
               local foldmethod = vim.api.nvim_exec('set foldmethod?', true):match('foldmethod=(%S+)')

               actions.close(prompt_bufnr)

               vim.cmd("edit " .. selection.value)
               vim.cmd("set foldmethod=" .. foldmethod)
            end
         },
      },

      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case"
      },
   },

   pickers = {
      git_commits = { theme = "dropdown" },
      git_status = { theme = "dropdown" },
      grep_string = { theme = "dropdown" },
      find_files = { theme = "dropdown" },
      buffers = { theme = "dropdown" },
      marks = { theme = "dropdown" },
   },
})

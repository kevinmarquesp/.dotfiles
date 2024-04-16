local NVIM_CONFIG = os.getenv("HOME") .. "/.config/nvim/"

local VIM_FILES = {
   "vimscript/autocmd.vim",
   "vimscript/indent.vim",
   "vimscript/keybind.vim",
   "vimscript/settings.vim",
}

for _, file in ipairs(VIM_FILES) do
   local path = NVIM_CONFIG .. file

   vim.cmd("source " .. path)
end

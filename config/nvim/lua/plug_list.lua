local plug_list = {}

table.insert(plug_list, "kyazdani42/nvim-web-devicons")
table.insert(plug_list, "tpope/vim-surround")
table.insert(plug_list, "andweeb/presence.nvim")

table.insert(plug_list, require('plugins.c_editor_style'))
table.insert(plug_list, require('plugins.c_editor_interface'))
table.insert(plug_list, require('plugins.p_telescope'))
table.insert(plug_list, require('plugins.c_code_helpers'))
table.insert(plug_list, require('plugins.p_cmp'))
table.insert(plug_list, require('plugins.c_code_lspconfig'))

return plug_list

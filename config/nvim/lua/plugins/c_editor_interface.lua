--- Função básica de configuração, o que você colocaria no plug.config() deve
--- estar aqui; o famosos require("plug_name").setup()
local function plug_setup()
    -- Configurações do LUALINE
    -- ------------------------------------------------------------------------
    -- Bubbles config for lualine
    -- Author: lokesh-krishna
    -- MIT license, see LICENSE for more details.
    -- ------------------------------------------------------------------------
    local nord = require("lualine.themes.nord")
    nord.normal.c.bg = "None"

    require('lualine').setup({
        options = {
            theme = nord,
            component_separators = '|',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {{ 'mode', separator = { left = '' },
            right_padding = 2 }},
            lualine_b = { 'filename', 'branch' },
            lualine_c = { 'fileformat' },
            lualine_y = { 'filetype', 'progress' },
            lualine_z = {{ 'location', separator = { right = '' },
            left_padding = 2 }},
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_z = { 'location' },
        },
    })

    -- Configurações do BUFFERLINE
    -- ------------------------------------------------------------------------
    require("bufferline").setup({})
    require("scope").setup()

    -- Configurações do GITSIGNS
    -- ------------------------------------------------------------------------
    require("gitsigns").setup({
        signs = {
            add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
            change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' }
        }
    })
end

--- Helper function, ela deve ser usada no dentro de plug.config() para
--- garantir que os requires vão funcionar nas funções de configuração, tanto
--- pro plugin quanto pro usuário
local function verify_require(modules)
    for _, module in pairs(modules) do
        local status_ok, _ = pcall(require, module)
        if not status_ok then
            return false, module.." :: couldn't require this plugin"
        end
    end

    return true, nil
end

-- Coleção de plugins que desenham coisas na tela, que dão informações úteis
-- sobre os buffers, lsp, o que for. Basicamente o bufferline e o lualine
return {
    "nvim-lualine/lualine.nvim",

    dependencies = {
        "akinsho/bufferline.nvim",
        "tiagovla/scope.nvim",
        "lewis6991/gitsigns.nvim",
    },

    config = function()
        local status_ok, info = verify_require({ "lualine", "bufferline",
            "scope", "gitsigns" })
        if not status_ok then
            print(info)
            return
        end

        plug_setup()
    end,
}

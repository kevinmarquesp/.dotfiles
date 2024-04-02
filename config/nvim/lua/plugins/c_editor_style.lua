--- Função básica de configuração, o que você colocaria no plug.config() deve
--- estar aqui; o famosos require("plug_name").setup()
local function plug_setup()
    require("nord").set()

    vim.g.nord_contrast = true
    vim.g.nord_borders = true
    vim.g.nord_disable_background = false
    vim.g.nord_italic = false
    vim.g.nord_uniform_diff_background = true
    vim.g.nord_bold = false
end

--- Essa função serve para você separar a configuração do plugin de algumas
--- customizações e detalhes que estão mais próximos do usuário final, como
--- keymaps e similares
local function user_setup()
    vim.cmd('colorscheme nord')

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
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

-- Plugins relacionados ao estilo da interface, coisa que não faria tanta
-- diferença no meu workflow se não existisse, apenas conforto visual
return {
    "shaunsingh/nord.nvim",

    dependencies = {
        "akinsho/bufferline.nvim",
    },

    config = function()
        local status_ok, info = verify_require({ "nord" })
        if not status_ok then
            print(info)
            return
        end

        plug_setup()
        vim.schedule(user_setup)
    end,
}

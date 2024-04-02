--- Função básica de configuração, o que você colocaria no plug.config() deve
--- estar aqui; o famosos require("plug_name").setup()
local function plug_setup()
end

--- Essa função serve para você separar a configuração do plugin de algumas
--- customizações e detalhes que estão mais próximos do usuário final, como
--- keymaps e similares
local function user_setup()
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

-- {{Descrição básica e breve do plugin/coleção de plugins}}
return {
    "{{repo}}",

    dependencies = {
        "{{repo_alt}}",
    },

    config = function()
        local status_ok, info = verify_require({ "{{module}}" })
        if not status_ok then
            print(info)
            return
        end

        plug_setup()
        vim.schedule(user_setup)
    end,
}

--- Função básica de configuração, o que você colocaria no plug.config() deve
--- estar aqui; o famosos require("plug_name").setup()
local function plug_setup()
    require("nvim-autopairs").setup()
    require("nvim-treesitter.configs").setup({
        sync_install = true,

        ensure_installed = {
            "lua", "vim", "bash", "python", "elixir", "javascript",
            "typescript", "c", "cpp", "go"
        },

        highlight = {
            enable = true,
            disable = { 'html', 'vim', 'vue' },
            additional_vim_regex_highlighting = true,
        },

        indent = {
            enable = true,
            disable = { 'scss', 'css', 'sass' },
        },
    })
end

--- Essa função serve para você separar a configuração do plugin de algumas
--- customizações e detalhes que estão mais próximos do usuário final, como
--- keymaps e similares
local function user_setup()
    vim.keymap.set("n", "<cr>", ":Commentary<cr>")
    vim.keymap.set("v", "<cr>", ":'<'>Commentary<cr>")
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

-- Jeito melhor e mais rápido de pintar a sintaxe das linguagens mais famosas
-- e lidar com a identação
return {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
        "tpope/vim-commentary",
        "windwp/nvim-autopairs",
    },

    config = function()
        local status_ok, info = verify_require({ "nvim-treesitter.configs",
        "nvim-autopairs" })
        if not status_ok then
            print(info)
            return
        end

        plug_setup()
        vim.schedule(user_setup)
    end,
}

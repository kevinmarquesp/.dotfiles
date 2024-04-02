--- Função básica de configuração, o que você colocaria no plug.config() deve
--- estar aqui; o famosos require("plug_name").setup()
local function plug_setup()
    local mason_lspconfig = require("mason-lspconfig")

    require("mason").setup()
    require("neodev").setup()
    require("fidget").setup({})

    local servers = {} -- default server to ensure that is installed

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers)
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                -- on_attach = function(_, bufnr) return end,
                settings = servers[server_name],
            })
        end,
    })
end

--- Essa função serve para você separar a configuração do plugin de algumas
--- customizações e detalhes que estão mais próximos do usuário final, como
--- keymaps e similares
local function user_setup()
    local opts = { remap = false }
    local map = vim.keymap.set

    map("n", "gd",           vim.lsp.buf.definition,       opts)
    map("n", "K",            vim.lsp.buf.hover,            opts)
    map("n", "]d",           vim.diagnostic.goto_next,     opts)
    map("n", "[d",           vim.diagnostic.goto_prev,     opts)
    --map("i", "<c-h>",        vim.lsp.buf.signature_help,   opts)
    map("n", "<leader>vca",  vim.lsp.buf.code_action,      opts)
    map("n", "<leader><f3>", vim.lsp.buf.references,       opts)
    map("n", "<leader><f2>", vim.lsp.buf.rename,           opts)
    map("n", "<leader>d",    vim.lsp.buf.workspace_symbol, opts)
    map("n", "<c-k>",        vim.diagnostic.open_float,    opts)
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

-- Configurações dos servidores de linguagem, essa config não instala nada
-- por padrão, o ideal é ir instalando cadar lsp a medida que é necessário
return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "j-hui/fidget.nvim",
    },

    config = function()
        local status_ok, info = verify_require({ "lspconfig", "mason",
            "mason-lspconfig", "neodev", "fidget" })
        if not status_ok then
            print(info)
            return
        end

        plug_setup()
        vim.schedule(user_setup)
    end,
}

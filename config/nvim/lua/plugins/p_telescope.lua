--- Função básica de configuração, o que você colocaria no plug.config() deve
--- estar aqui; o famosos require("plug_name").setup()
local function plug_setup()
    local actions = require("telescope.actions")
    local sorters = require("telescope.sorters")
    local previewers = require("telescope.previewers")

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
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-l>"] = actions.close,
                    ["<C-p>"] = actions.close,
                },
            },

            vimgrep_arguments = { "rg", "--color=never",
            "--no-heading", "--with-filename", "--line-number",
            "--column", "--smart-case" },
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
end

--- Essa função serve para você separar a configuração do plugin de algumas
--- customizações e detalhes que estão mais próximos do usuário final, como
--- keymaps e similares
local function user_setup()
    local telescope_builtin = require("telescope.builtin")
    vim.keymap.set("n", "<c-p>",      telescope_builtin.find_files)
    vim.keymap.set("n", "<leader>p",  telescope_builtin.buffers)
    vim.keymap.set("n", "<leader>fc", telescope_builtin.git_commits)
    vim.keymap.set("n", "<leader>fs", telescope_builtin.git_status)
    vim.keymap.set("n", "<leader>fm", telescope_builtin.marks)
    vim.keymap.set("n", "<leader>?",  ":Telescope keymaps<cr>")
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

-- Simplesmente o mmelhor plugin para fuzzy file search disponível para
-- usuário de Neovim (juntamente com a melhor configuração)
return {
    "nvim-telescope/telescope.nvim",

    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local status_ok, info = verify_require({ "telescope" })
        if not status_ok then
            print(info)
            return
        end

        plug_setup()
        vim.schedule(user_setup)
    end,
}

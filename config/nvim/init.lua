local function load_user_profile()
    local NVIM_CONFIG_DIR = os.getenv("HOME").."/.config/nvim"
    local SHARED_CONFIG_PATH = NVIM_CONFIG_DIR.."/shared"

    local SHARED_CONFIG_FILES = { "keymaps.vim", "commands.vim",
        "indentation_rules.vim", "settings.vim", }
    
    for _, file in ipairs(SHARED_CONFIG_FILES) do
        local vim_command = "source "..SHARED_CONFIG_PATH.."/"..file
        vim.cmd(vim_command)
    end
end

local function load_plugin_manager()
    local PlugManager = require("plug_manager")

    PlugManager.install_manager()
    PlugManager.fetch_plugins()
end

local function load_user_commands()
    local UserCommands = require("user_commands")
    UserCommands:load()
end

load_user_profile()
load_plugin_manager()
load_user_commands()

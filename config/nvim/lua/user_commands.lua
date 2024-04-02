local UserCommands = {}

function UserCommands._cmd_newplug()
    local NVIM_CONFIG_DIR = os.getenv("HOME").."/.config/nvim"
    local DEST_DIR = NVIM_CONFIG_DIR.."/lua/plugins"
    local NEWPLUG_SCRIPT = NVIM_CONFIG_DIR.."/scripts/new_plug.sh"

    local file_name = vim.fn.input("Plugin file name: ")
    os.execute(NEWPLUG_SCRIPT.." "..file_name)
    vim.cmd("edit "..DEST_DIR.."/"..file_name..".lua")
end

function UserCommands:load()
    vim.api.nvim_create_user_command('NewPlug', self._cmd_newplug, {})
end

return UserCommands

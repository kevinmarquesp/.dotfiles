local PlugManager = {}

function PlugManager.install_manager()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    
    vim.opt.rtp:prepend(lazypath)
end

function PlugManager.fetch_plugins()
    local status_ok, lazy = pcall(require, "lazy")
    if not status_ok then
        print("warn :: lazy.nvim was not installed")
        return
    end

    local plugins = require("plug_list")
    lazy.setup(plugins)
end

return PlugManager

local fn = vim.fn

-- Automatically Install Packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "INSTALLING PACKER.NVIM"
    vim.cmd [[packadd packer.nvim]]
end

-- Automatically Do PackerSync
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]


-- Protected Call to Packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("packer not fount")
    return
end

-- Popup Widow for Packer
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Plugins
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Packer Itself

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end
)

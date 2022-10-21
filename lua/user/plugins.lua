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
    use "windwp/nvim-autopairs" -- AutoPairs
    use "akinsho/toggleterm.nvim" -- ToggleTerm
    use "numToStr/Comment.nvim" -- Easy Comment
    use "nvim-lua/plenary.nvim" -- Plenary
    use "nvim-lua/popup.nvim" -- Popup
    use "sunjon/shade.nvim" -- Shade
    use "lewis6991/gitsigns.nvim" -- GitSigns
    use "github/copilot.vim" -- GitHub Copilot
    use "szw/vim-maximizer" -- Maximizer
    use "fgheng/winbar.nvim" -- WinBar
    use "windwp/nvim-ts-autotag" -- AutoTags for WebDev

    -- LSP
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/nvim-lsp-installer",
            "jose-elias-alvarez/null-ls.nvim",
            "j-hui/fidget.nvim",
        },

    }

    -- Code Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },

    }

    -- Snippets
    use {
        "L3MON4D3/LuaSnip",
        requires = {
            "rafamadriz/friendly-snippets",
        },
    }
    -- ColorScheme
    use {
        "gruvbox-community/gruvbox",
        config = function()
            vim.cmd [[colorscheme gruvbox]]
        end,
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "p00f/nvim-ts-rainbow",
        },
    }

    -- NvimTree
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
    }

    -- LuaLine
    use {
        "hoob3rt/lualine.nvim",
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
    }

    -- Dart/Flutter
    use {
        "akinsho/flutter-tools.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    }





    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end
)

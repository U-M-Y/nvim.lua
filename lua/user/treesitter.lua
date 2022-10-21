-- Protected Call to TreeSitter
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("nvim-treesitter not found")
    return
end

configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" },
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    autotag = {
        enable = true,
    },

}

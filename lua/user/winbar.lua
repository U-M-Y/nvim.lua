-- Protected Call to WinBar
local status_ok, winbar = pcall(require, "winbar")
if not status_ok then
    vim.notify("winbar not found")
    return
end

winbar.setup({
    enabled = true,

    show_file_path = false,
    show_symbols = true,

    colors = {
        path = '',
        file_name = '',
        symbols = '',
    },

    icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
    }
})

-- Protected Call to Figlet
local cmp_status_ok, fidget = pcall(require, "fidget")
if not cmp_status_ok then
    vim.notify("fidget not found")
    return
end

fidget.setup {}

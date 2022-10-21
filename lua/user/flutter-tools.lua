-- Protected Call to FlutterTools
local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
    vim.notify("flutter-tools not found")
    return
end

-- Protected Call to CMP_NVIM_LSP
local status_ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok_cmp then
    vim.notify("cmp_nvim_lsp not found")
    return
end
local function lsp_highlight_document(client)
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                augroup lsp_document_highlight
                    autocmd! * <buffer>
                    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-f>", "<cmd>:Format<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ep", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>'
        , opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "es",
        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>en", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>'
        , opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format{ async = true }' ]]
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
end

require("telescope").load_extension("flutter")

flutter_tools.setup {
    ui = {
        border = "rounded",
        notification_style = "notify",
    },
    decorations = {
        statusline = {
            device = true,
        }
    },
    outline = {
        open_cmd = "30vnew",
        auto_open = false,
    },
    lsp = {
        on_attach = function(client, bufnr)
            lsp_keymaps(bufnr)
            lsp_highlight_document(client)
        end,
        capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            analysisExcludedFolders = { "/home/hacr/Downloads/flutter/" },
            renameFilesWithClasses = "always",
            updateImportsOnRename = true,
            enableSdkFormatter = true,
            enableSnippets = true,
        }
    }
}

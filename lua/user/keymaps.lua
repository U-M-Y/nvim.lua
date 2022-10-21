local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("","<Space>", "<NOP>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better Window Movement
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)

-- Resize With Equal and Minus
keymap("n", "<leader>-", ":vertical resize -2<CR>", opts)
keymap("n", "<leader>=", ":vertical resize +2<CR>", opts)

-- Navigate Between Buffers
keymap("n", "<leader>bb", ":buffers<CR>", opts)
keymap("n", "<leader>bn", ":bn<CR>", opts)
keymap("n", "<leader>bp", ":bp<CR>", opts)

-- Remap ESC
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Horizontal Text Movement
keymap("v", "<", "<gv", opts)   -- Left
keymap("v", ">", ">gv", opts)   -- Right

-- Vertical Text Movement
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)   -- Down
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)   -- Up
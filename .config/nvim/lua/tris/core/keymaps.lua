vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "te", ":tabedit<CR>", { desc = "Open new tab" }) -- open new tab
-- NOTE: disable because bufferline uses mode 'buffer'
--keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
--keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
--keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
--keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
--keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.api.nvim_set_keymap("i", "<esc>", "<esc>:update<CR>", { noremap = true, silent = true }) -- Autosave

--- disable arrow key
vim.api.nvim_set_keymap("n", "<Up>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", "<NOP>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<Up>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Down>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Left>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Right>", "<NOP>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<Up>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Down>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Left>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Right>", "<NOP>", { noremap = true, silent = true })

-- turn of  hightlight search
vim.api.nvim_set_keymap("n", "<leader>nh", ":nohlsearch<CR>", { noremap = true, silent = true })

local map = vim.keymap.set

-- TODO: how to not use arrow but hjkl
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("i", "<esc>", "<esc>:update<CR>", { noremap = true, silent = true }) -- Autosave


keymap.set("n", "<c-h>", ":TmuxNavigateLeft<CR>")
keymap.set("n", "<c-j>", ":TmuxNavigateDown<CR>")
keymap.set("n", "<c-k>", ":TmuxNavigateUp<CR>")
keymap.set("n", "<c-l>", ":TmuxNavigateRight<CR>")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

vim.api.nvim_set_keymap("i", "<esc>", "<esc>:update<CR>", { noremap = true, silent = true }) -- Autosave

local map = vim.keymap.set

-- Delete/paste without clobbering the yank register
map("n", "x", '"_x', { desc = "Delete char (no yank)" })
map({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete (no yank)" })
map("x", "<leader>p", '"_dP', { desc = "Paste over selection (keep yank)" })

-- Copy "path#Lnn" for pasting into an agent prompt
local function copy_ref(abs)
  local ref = ("%s#L%d"):format(vim.fn.expand(abs and "%:p" or "%:."), vim.fn.line("."))
  vim.fn.setreg("+", ref)
  vim.notify(ref, vim.log.levels.INFO, { title = "Copied" })
end
map("n", "<leader>yf", function()
  copy_ref(false)
end, { desc = "Copy relative path#L" })
map("n", "<leader>yp", function()
  copy_ref(true)
end, { desc = "Copy absolute path#L" })

-- Copy visual selection as a fenced code block headed by path#Lstart-end
map("x", "<leader>yc", function()
  local s, e = vim.fn.line("v"), vim.fn.line(".")
  if s > e then
    s, e = e, s
  end
  local lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
  local out = ("%s#L%d-%d\n```%s\n%s\n```"):format(vim.fn.expand("%:."), s, e, vim.bo.filetype, table.concat(lines, "\n"))
  vim.fn.setreg("+", out)
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
  vim.notify(("%d lines"):format(e - s + 1), vim.log.levels.INFO, { title = "Copied code block" })
end, { desc = "Copy selection as code block" })

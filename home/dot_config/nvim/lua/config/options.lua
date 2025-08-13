-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.title = true -- show the window title in the terminal

opt.relativenumber = true
opt.number = true
opt.backup = false

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true

opt.wrap = true

opt.cursorline = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- turn off swapfile
opt.swapfile = false

opt.winbar = "%=%m %f"

opt.formatoptions:append({ "r" }) --enables formatting comments by adding asterisks in block comments.

-- FOLD
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldcolumn = "0" -- disable extra column to display information on folds
opt.foldtext = "" -- irst line of the fold will be syntax highlighted
opt.foldlevel = 99 -- disable minimum level of a fold that will be closed by default.
opt.foldlevelstart = 1 -- top level folds are open, but anything nested beyond that is closed
opt.foldnestmax = 4 -- once code gets beyond 4 levels it won't be broken down into more granular folds

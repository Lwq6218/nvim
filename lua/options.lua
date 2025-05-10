require "nvchad.options"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
-- vim.o.winborder = "rounded"
local opt = vim.opt
opt.signcolumn = "yes:2"
opt.wrap = true
opt.relativenumber = true
opt.cursorlineopt = "both"
-- opt.cmdheight = 0
-- opt.pumheight = 10
opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

vim.opt.laststatus = 0

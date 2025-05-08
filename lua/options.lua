require "nvchad.options"
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

local opt = vim.opt

opt.signcolumn = "yes:2"
opt.wrap = true
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.cursorlineopt = "both" -- Enable highlighting of the current line
-- opt.cmdheight = 0
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

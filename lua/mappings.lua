require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("i", "jk", "<ESC>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "file save" })
map({ "n", "i", "v" }, "<C-z>", "<cmd> undo <cr>", { desc = "history undo" })
map({ "n", "i", "v" }, "<C-y>", "<cmd> redo <cr>", { desc = "history redo" })
map("t", "<Esc>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
-- map({ "n", "i", "v" }, "<C-f>", function()
--   if vim.bo.filetype == "TelescopePrompt" then
--     vim.cmd "q!"
--   else
--     vim.cmd "Telescope current_buffer_fuzzy_find"
--   end
-- end, { desc = "search search in current buffer" })
-- map({ "n", "i", "v" }, "<A-f>", function()
--   if vim.bo.filetype == "TelescopePrompt" then
--     vim.cmd "q!"
--   else
--     vim.cmd "Telescope live_grep"
--   end
-- end, { desc = "search search across project" })

map({ "n", "i", "v", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggle vertical term" })
map({ "n", "i", "v", "t" }, "<C-/>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggle horizontal term" })
map({ "n", "i", "v", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })

map("n", "ge", vim.diagnostic.open_float, { desc = "LSP show diagnostics" })

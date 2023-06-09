local keymap = require('core.keybind')
local nmap, imap, cmap, xmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.tmap
local silent, noremap, expr, remap = keymap.silent, keymap.noremap, keymap.expr, keymap.remap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '
-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

xmap({
  { 'y', 'ygv<esc>', opts(noremap, silent) },
  -- better indenting
  { '<', '<gv' },
  { '>', '>gv' },
})

-- Insert Mappings
imap({
  'jk',
  '<esc>',
  opts(noremap, silent),
})

-- Normal Mappings
nmap({
  -- better up/down
  { 'j', "v:count == 0 ? 'gj' : 'j'", opts(silent, expr) },
  { 'k', "v:count == 0 ? 'gk' : 'k'", opts(silent, expr) },
  -- window jump
  { '<C-h>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', '<C-w>j', opts(noremap) },
  { '<C-k>', '<C-w>k', opts(noremap) },
  -- Resize window using <ctrl> arrow keys
  { '<C-Up>', cmd('resize +2'), opts('Increase window height') },
  { '<C-Down>', cmd('resize -2'), opts('Decrease window height') },
  { '<C-Left>', cmd('vertical resize -2'), opts('Decrease window width') },
  { '<C-Right>', cmd('vertical resize +2'), opts('Increase window width') },
  -- windows
  { '<leader>ww', '<C-W>p', opts(remap, 'Other window') },
  { '<leader>wd', '<C-W>c', opts(remap, 'Delete window') },
  { '<leader>w-', '<C-W>s', opts(remap, 'Split window below') },
  { '<leader>w|', '<C-W>v', opts(remap, 'Split window right') },
  { '<leader>-', '<C-W>s', opts(remap, 'Split window below') },
  { '<leader>|', '<C-W>v', opts(remap, 'Split window right') },
  { '<S-h>', cmd('bprevious'), opts('Prev buffer') },
  { '<S-l>', cmd('bnext'), opts('Next buffer') },
  { '[b', cmd('bprevious'), opts('Prev buffer') },
  { ']b', cmd('bnext'), opts('Next buffer') },
  -- plugin manager: Lazy.nvim
  { '<Leader>l', cmd('Lazy'), opts(noremap, silent) },
  { '<Leader>lu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>li', cmd('Lazy install'), opts(noremap, silent) },
  -- dashboard
  -- { '<Leader>n',  cmd('DashboardNewFile'),     opts(noremap, silent) },
  -- { '<Leader>ss', cmd('SessionSave'),          opts(noremap, silent) },
  -- { '<Leader>sl', cmd('SessionLoad'),          opts(noremap, silent) },
  -- Telescope
  { '<Leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fa', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  -- Nvim-tree
  { '<leader>e', cmd('NvimTreeToggle'), opts(noremap, silent) },
})

-- Terminal Mappings
tmap({
  { '<esc><esc>', '<c-\\><c-n>', opts('Enter Normal Mode') },
  { '<C-h>', cmd('wincmd h'), opts('Go to left window') },
  { '<C-j>', cmd('wincmd j'), opts('Go to lower window') },
  { '<C-k>', cmd('wincmd k'), opts('Go to upper window') },
  { '<C-l>', cmd('wincmd l'), opts('Go to right window') },
  { '<C-/>', cmd('close'), opts('Hide Terminal') },
})

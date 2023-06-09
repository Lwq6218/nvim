local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
})
package({
  'dstein64/vim-startuptime',
  cmd = 'StartupTime',
  config = function()
    vim.g.startuptime_tries = 10
  end,
})
-- package({
--   'ggandor/leap.nvim',
--   keys = {
--     { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
--     { 'S', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
--     { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
--   },
--   config = function(_, opts)
--     local leap = require('leap')
--     for k, v in pairs(opts) do
--       leap.opts[k] = v
--     end
--     leap.add_default_mappings(true)
--     vim.keymap.del({ 'x', 'o' }, 'x')
--     vim.keymap.del({ 'x', 'o' }, 'X')
--   end,
-- })
-- package({
--   'ggandor/flit.nvim',
--   keys = function()
--     ---@type LazyKeys[]
--     local ret = {}
--     for _, key in ipairs({ 'f', 'F', 't', 'T' }) do
--       ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
--     end
--     return ret
--   end,
--   opts = { labeled_modes = 'nx' },
-- })

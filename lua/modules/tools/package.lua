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

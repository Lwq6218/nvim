local package = require('core.pack').package
local conf = require('modules.completion.config')

package({
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = conf.nvim_cmp,
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      config = conf.lua_snip,
    },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
  },
})

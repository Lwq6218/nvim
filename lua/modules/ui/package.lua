local package = require('core.pack').package
local conf = require('modules.ui.config')

package({
  -- icons
  'nvim-tree/nvim-web-devicons',
  lazy = true,
})

package({
  -- ui components
  'MunifTanjim/nui.nvim',
  lazy = true,
})
-- better vim.ui
package({
  'stevearc/dressing.nvim',
  lazy = true,
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(...)
      require('lazy').load({ plugins = { 'dressing.nvim' } })
      return vim.ui.select(...)
    end
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.input = function(...)
      require('lazy').load({ plugins = { 'dressing.nvim' } })
      return vim.ui.input(...)
    end
  end,
})
package({
  'rcarriga/nvim-notify',
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss({ silent = true, pending = true })
      end,
      desc = 'Dismiss all Notifications',
    },
  },
  opts = {
    -- background_colour = '#000000',
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  },
})

package({
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = conf.noice,
})
package({
  'catppuccin/nvim',
  name = 'catppuccin',
  config = conf.catppuccin,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
package({
  'rose-pine/neovim',
  name = 'rose-pine',
  config = conf.rose_pine,
})
package({
  {
    'AlexvZyl/nordic.nvim',
    config = function()
      require('nordic').setup({
        transparent_bg = false,
        bright_border = true,
      })
    end,
  },
})
package({
  'SmiteshP/nvim-navic',
  lazy = true,
  init = function()
    vim.g.navic_silence = true
    require('utils').on_attach(function(client, buffer)
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, buffer)
      end
    end)
  end,
  opts = function()
    return {
      separator = ' ',
      highlight = true,
      depth_limit = 5,
    }
  end,
})
package({
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = conf.indent_blankline,
})
package({
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = conf.alpha,
})
package({
  'echasnovski/mini.indentscope',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    symbol = '│',
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'alpha',
        'neo-tree',
        'Trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'NvimTree',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
})

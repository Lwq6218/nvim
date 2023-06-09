local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    init = function()
      -- PERF: no need to load the plugin, if we only need its queries for mini.ai
      local plugin = require('lazy.core.config').spec.plugins['nvim-treesitter']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local enabled = false
      if opts.textobjects then
        for _, mod in ipairs({ 'move', 'select', 'swap', 'lsp_interop' }) do
          if opts.textobjects[mod] and opts.textobjects[mod].enable then
            enabled = true
            break
          end
        end
      end
      if not enabled then
        require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
      end
    end,
  },
})
package({
  'echasnovski/mini.ai',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter-textobjects' },
  opts = function()
    local ai = require('mini.ai')
    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }, {}),
        f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
        c = ai.gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' }, {}),
      },
    }
  end,
  config = function(_, opts)
    require('mini.ai').setup(opts)
  end,
})
package({
  'echasnovski/mini.pairs',
  event = 'VeryLazy',
  opts = {},
})
package({
  'JoosepAlviste/nvim-ts-context-commentstring',
  lazy = true,
})
package({
  'echasnovski/mini.comment',
  event = 'VeryLazy',
  opts = {
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
})
package({
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = true,
  -- stylua: ignore
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
  },
})
package({
  'echasnovski/mini.animate',
  event = 'VeryLazy',
  opts = function()
    -- don't use animate when scrolling with the mouse
    local mouse_scrolled = false
    for _, scroll in ipairs({ 'Up', 'Down' }) do
      local key = '<ScrollWheel' .. scroll .. '>'
      vim.keymap.set({ '', 'i' }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    local animate = require('mini.animate')
    return {
      resize = {
        timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
      },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
        subscroll = animate.gen_subscroll.equal({
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end
            return total_scroll > 1
          end,
        }),
      },
    }
  end,
})
package({
  'akinsho/nvim-bufferline.lua',
  event = 'VeryLazy',
  config = conf.bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
package({
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle' },
  config = conf.nvim_tree,
})

--FIX: config has bug to fix
package({
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = true,
})

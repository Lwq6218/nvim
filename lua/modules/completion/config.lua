local config = {}

function config.nvim_cmp()
  local icons = {
    kind = require('utils.icons').get('kind'),
    type = require('utils.icons').get('type'),
    cmp = require('utils.icons').get('cmp'),
  }
  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local border = function(hl_name)
    return {
      { '╭', hl_name },
      { '─', hl_name },
      { '╮', hl_name },
      { '│', hl_name },
      { '╯', hl_name },
      { '─', hl_name },
      { '╰', hl_name },
      { '│', hl_name },
    }
  end
  local cmp = require('cmp')

  cmp.setup({
    preselect = cmp.PreselectMode.Item,
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    window = {
      completion = {
        border = border('PmenuBorder'),
        winhighlight = 'Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel',
        scrollbar = false,
      },
      documentation = {
        border = border('CmpDocBorder'),
        winhighlight = 'Normal:CmpDoc',
      },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        -- require("copilot_cmp.comparators").prioritize,
        -- require("copilot_cmp.comparators").score,
        -- require("cmp_tabnine.compare"),
        cmp.config.compare.offset, -- Items closer to cursor will have lower priority
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = function(entry, vim_item)
        local lspkind_icons = vim.tbl_deep_extend('force', icons.kind, icons.type, icons.cmp)
        -- load lspkind icons
        vim_item.kind =
          string.format(' %s  %s', lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or '')

        vim_item.menu = setmetatable({
          -- cmp_tabnine = "[TN]",
          -- copilot = "[CPLT]",
          cmdline = '[CMD]',
          buffer = '[BUF]',
          orgmode = '[ORG]',
          nvim_lsp = '[LSP]',
          -- nvim_lua = "[LUA]",
          path = '[PATH]',
          -- tmux = "[TMUX]",
          -- treesitter = "[TS]",
          luasnip = '[SNIP]',
          -- spell = "[SPELL]",
        }, {
          __index = function()
            return '[BTN]' -- builtin/unknown source names
          end,
        })[entry.source.name]

        local label = vim_item.abbr
        local truncated_label = vim.fn.strcharpart(label, 0, 80)
        if truncated_label ~= label then
          vim_item.abbr = truncated_label .. '...'
        end

        return vim_item
      end,
    },
    matching = {
      disallow_partial_fuzzy_matching = false,
    },
    performance = {
      async_budget = 1,
      max_view_entries = 150,
    },
    -- You can set mappings if you want
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<S-CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-w>'] = cmp.mapping.close(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif require('luasnip').expand_or_locally_jumpable() then
          vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'))
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require('luasnip').jumpable(-1) then
          vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    -- You should specify your *installed* sources.
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
    experimental = {
      ghost_text = {
        hl_group = 'Whitespace',
      },
    },
  })
  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline({
      ['<CR>'] = cmp.mapping({
        c = function(fallback)
          if cmp.visible() then
            return cmp.confirm({ select = true })
          end
          fallback()
        end,
      }),
    }),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
      ['<CR>'] = cmp.mapping({
        c = function(fallback)
          if cmp.visible() then
            return cmp.confirm({ select = true })
          end
          fallback()
        end,
      }),
    }),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        keyword_length = 3,
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

return config

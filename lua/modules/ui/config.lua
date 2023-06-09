local config = {}
local transparent_background = false
local clear = {}

function config.rose_pine()
  require('rose-pine').setup({
    dark_variant = 'main',
    disable_italics = true,
    highlight_groups = {
      ['@label'] = { fg = 'gold', bold = true },
      ['@symbol'] = { fg = 'foam' },
      ['@string'] = { fg = 'gold' },
      ['@keyword.return'] = { fg = 'love' },
      TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
      TelescopeNormal = { bg = 'none' },
      TelescopePromptNormal = { bg = 'base' },
      TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
      TelescopeSelection = { fg = 'text', bg = 'base' },
      TelescopeSelectionCaret = { fg = 'rose', bg = 'base' },
      diffAdded = { fg = 'pine' },
      diffRemoved = { fg = 'love' },
      diffChanged = { fg = 'iris' },
    },
  })
end

function config.catppuccin()
  require('catppuccin').setup({
    flavour = 'mocha', -- Can be one of: latte, frappe, macchiato, mocha
    background = { light = 'latte', dark = 'mocha' },
    dim_inactive = {
      enabled = false,
      -- Dim inactive splits/windows/buffers.
      -- NOT recommended if you use old palette (a.k.a., mocha).
      shade = 'dark',
      percentage = 0.15,
    },
    transparent_background = transparent_background,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    styles = {
      comments = { 'italic' },
      properties = { 'italic' },
      functions = { 'bold' },
      keywords = { 'italic' },
      operators = { 'bold' },
      conditionals = { 'bold' },
      loops = { 'bold' },
      booleans = { 'bold', 'italic' },
      numbers = {},
      types = {},
      strings = {},
      variables = {},
    },
    integrations = {
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
      },
      treesitter = true,
      alpha = true,
      cmp = true,
      fidget = true,
      indent_blankline = { enabled = true, colored_indent_levels = false },
      mason = true,
      mini = true,
      neotree = true,
      noice = true,
      ts_rainbow = true,
    },
    color_overrides = {},
    highlight_overrides = {
      ---@param cp palette
      all = function(cp)
        return {
          -- For base configs
          NormalFloat = {
            fg = cp.text,
            -- bg = transparent_background and cp.none or cp.mantle,
            bg = cp.none,
          },
          -- FloatBorder = {
          --   fg = transparent_background and cp.blue or cp.mantle,
          --   bg = transparent_background and cp.none or cp.mantle,
          -- },
          CursorLineNr = { fg = cp.green },

          -- For native lsp configs
          DiagnosticVirtualTextError = { bg = cp.none },
          DiagnosticVirtualTextWarn = { bg = cp.none },
          DiagnosticVirtualTextInfo = { bg = cp.none },
          DiagnosticVirtualTextHint = { bg = cp.none },
          LspInfoBorder = { link = 'FloatBorder' },

          -- For mason.nvim
          MasonNormal = { link = 'NormalFloat' },

          -- For nvim-cmp and wilder.nvim
          Pmenu = { fg = cp.overlay2, bg = transparent_background and cp.none or cp.base },
          PmenuBorder = {
            fg = cp.surface1,
            bg = transparent_background and cp.none or cp.base,
          },
          PmenuSel = { bg = cp.green, fg = cp.base },
          CmpItemAbbr = { fg = cp.overlay2 },
          CmpItemAbbrMatch = { fg = cp.blue, style = { 'bold' } },
          --FIX:cmpdoc border
          CmpDoc = { link = 'NormalFloat' },

          -- CmpDocBorder = {
          --   fg = transparent_background and cp.surface1 or cp.mantle,
          --   bg = transparent_background and cp.none or cp.mantle,
          -- },
          -- For trouble.nvim
          TroubleNormal = { bg = transparent_background and cp.none or cp.base },

          -- For telescope.nvim
          -- TelescopeBorder = { fg = cp.mantle, bg = cp.mantle },ui/con
          -- TelescopePromptBorder = { fg = cp.surface0, bg = cp.surface0 },
          -- TelescopePromptNormal = { fg = cp.text, bg = cp.surface0 },
          -- TelescopePromptPrefix = { fg = cp.flamingo, bg = cp.surface0 },
          TelescopeNormal = { bg = cp.mantle },
          TelescopePreviewTitle = { fg = cp.base, bg = cp.green },
          TelescopePromptTitle = { fg = cp.base, bg = cp.red },
          -- TelescopeResultsTitle = { fg = cp.mantle, bg = cp.mantle },
          -- TelescopeSelection = { fg = cp.text, bg = cp.surface0 },
          TelescopeResultsDiffAdd = { fg = cp.green },
          TelescopeResultsDiffChange = { fg = cp.yellow },
          TelescopeResultsDiffDelete = { fg = cp.red },

          -- For treesitter
          ['@keyword.return'] = { fg = cp.pink, style = clear },
        }
      end,
    },
  })
end

function config.indent_blankline()
  require('indent_blankline').setup({
    char = '│',
    show_current_context = false,
    show_trailing_blankline_indent = false,
    filetype_exclude = {
      'help',
      'log',
      'TelescopePrompt',
      'alpha',
      'neo-tree',
      'lazy',
      'mason',
      'notify',
      'toggleterm',
    },
    buftype_exclude = { 'terminal', 'nofile', 'prompt' },
  })
end

function config.alpha()
  local dashboard = require('alpha.themes.dashboard')
  local logo = [[
       ___       __   ___  ___  ________  _________       ___  ___  ________  ___  ___  ___
      |\  \     |\  \|\  \|\  \|\   __  \|\___   ___\    |\  \|\  \|\   __  \|\  \|\  \|\  \
      \ \  \    \ \  \ \  \\\  \ \  \|\  \|___ \  \_|    \ \  \\\  \ \  \|\  \ \  \ \  \ \  \
       \ \  \  __\ \  \ \   __  \ \   __  \   \ \  \      \ \  \\\  \ \   ____\ \  \ \  \ \  \
        \ \  \|\__\_\  \ \  \ \  \ \  \ \  \   \ \  \      \ \  \\\  \ \  \___|\ \__\ \__\ \__\
         \ \____________\ \__\ \__\ \__\ \__\   \ \__\      \ \_______\ \__\    \|__|\|__|\|__|
          \|____________|\|__|\|__|\|__|\|__|    \|__|       \|_______|\|__|        ___  ___  ___
                                                                                   |\__\|\__\|\__\
                                                                                   \|__|\|__|\|__|
   ]]
  dashboard.section.header.val = vim.split(logo, '\n')
  dashboard.section.buttons.val = {
    dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
    dashboard.button('e', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
    dashboard.button('t', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
    dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
    dashboard.button('p', ' ' .. ' Projects', ':Telescope projects<CR>'),
    dashboard.button('l', '󰒲 ' .. ' Lazy', ':Lazy<CR>'),
    dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
  }
  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = 'AlphaButtons'
    button.opts.hl_shortcut = 'AlphaShortcut'
  end
  dashboard.section.header.opts.hl = 'AlphaHeader'
  dashboard.section.buttons.opts.hl = 'AlphaButtons'
  dashboard.section.footer.opts.hl = 'AlphaFooter'
  dashboard.opts.layout[1].val = 8

  -- close Lazy and re-open when the dashboard is ready
  if vim.o.filetype == 'lazy' then
    vim.cmd.close()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'AlphaReady',
      callback = function()
        require('lazy').show()
      end,
    })
  end

  require('alpha').setup(dashboard.opts)

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    callback = function()
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = '💪 Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms 💪'
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

--TODO: modify cmdline_pop position
function config.noice()
  require('noice').setup({
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
          },
        },
        view = 'mini',
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  })
end

return config

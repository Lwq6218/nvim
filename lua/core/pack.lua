local uv, api, fn = vim.uv, vim.api, vim.fn
local icons = {
  kind = require('utils.icons').get('kind'),
  documents = require('utils.icons').get('documents'),
  ui = require('utils.icons').get('ui'),
  ui_sep = require('utils.icons').get('ui', true),
  misc = require('utils.icons').get('misc'),
}

local util = {}
function util.path_join(...)
  return table.concat({ ... }, package.config:sub(1, 1) == '\\' and '\\' or '/')
end

local pack = {}
pack.__index = pack

function pack:load_modules_packages()
  local modules_dir = util.path_join(self.config_path, 'lua', 'modules')
  self.repos = {}

  local list = vim.fs.find('package.lua', { path = modules_dir, type = 'file', limit = 10 })
  if #list == 0 then
    return
  end

  for _, f in pairs(list) do
    local _, pos = f:find(modules_dir)
    f = f:sub(pos - 6, #f - 4)
    require(f)
  end
end

function pack:boot_strap()
  self.data_path = fn.stdpath('data')
  self.config_path = fn.stdpath('config')
  local lazy_path = util.path_join(self.data_path, 'lazy', 'lazy.nvim')
  local state = uv.fs_stat(lazy_path)
  if not state then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazy_path,
    })
  end
  vim.opt.rtp:prepend(lazy_path)

  local lazy = require('lazy')
  local opts = {
    ui = {
      -- a number <1 is a percentage., >1 is a fixed size
      size = { width = 0.88, height = 0.8 },
      wrap = true, -- wrap the lines in the ui
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = 'rounded',
      icons = {
        cmd = icons.misc.Code,
        config = icons.ui.Gear,
        event = icons.kind.Event,
        ft = icons.documents.Files,
        init = icons.misc.ManUp,
        import = icons.documents.Import,
        keys = icons.ui.Keyboard,
        loaded = icons.ui.Check,
        not_loaded = icons.misc.Ghost,
        plugin = icons.ui.Package,
        runtime = icons.misc.Vim,
        source = icons.kind.StaticMethod,
        start = icons.ui.Play,
        list = {
          icons.ui_sep.BigCircle,
          icons.ui_sep.BigUnfilledCircle,
          icons.ui_sep.Square,
          icons.ui_sep.ChevronRight,
        },
      },
    },
    lockfile = util.path_join(self.data_path, 'lazy-lock.json'),
    defaults = {
      -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
      -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
      lazy = false,
      -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
      -- have outdated releases, which may break your Neovim install.
      version = false, -- always use the latest git commit
      -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { 'catppuccin', 'rose-pine' } },
    checker = { enabled = true }, -- automatically check for plugin updates
    performance = {
      rtp = {
        reset = true, -- reset the runtime path to $VIMRUNTIME and the config directory
        ---@type string[]
        paths = {}, -- add any custom paths here that you want to include in the rtp
      },
      cache = {
        enabled = true,
        path = fn.stdpath('cache') .. '/lazy/cache',
        -- Once one of the following events triggers, caching will be disabled.
        -- To cache all modules, set this to `{}`, but that is not recommended.
        disable_events = { 'UIEnter', 'BufReadPre' },
        ttl = 3600 * 24 * 2, -- keep unused modules for up to 2 days
      },
      reset_packpath = true, -- reset the package path to improve startup time
    },
  }
  self:load_modules_packages()
  lazy.setup(self.repos, opts)

  for k, v in pairs(self) do
    if type(v) ~= 'function' then
      self[k] = nil
    end
  end
end

function pack.package(repo)
  if not pack.repos then
    pack.repos = {}
  end
  table.insert(pack.repos, repo)
end

return pack

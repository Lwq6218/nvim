local config = {}

function config.nvim_treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'cpp', 'lua', 'c' },
    ignore_install = { 'phpdoc' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<cr>',
        node_incremental = '<cr>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
  })
end

function config.bufferline()
  local icons = { ui = require('utils.icons').get('ui') }

  require('bufferline').setup({
    options = {
      number = nil,
      modified_icon = icons.ui.Modified,
      buffer_close_icon = icons.ui.Close,
      left_trunc_marker = icons.ui.Left,
      right_trunc_marker = icons.ui.Right,
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      enforce_regular_tabs = true,
      persist_buffer_sort = true,
      always_show_bufferline = false,
      separator_style = 'thin',
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count)
        return '(' .. count .. ')'
      end,
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File Explorer',
          text_align = 'center',
          padding = 1,
          highlight = 'Directory',
        },
      },
    },
  })
end

function config.nvim_tree()
  local icons = {
    diagnostics = require('utils.icons').get('diagnostics'),
    documents = require('utils.icons').get('documents'),
    git = require('utils.icons').get('git'),
    ui = require('utils.icons').get('ui'),
  }
  require('nvim-tree').setup({
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    open_on_tab = false,
    respect_buf_cwd = false,
    sort_by = 'name',
    sync_root_with_cwd = true,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 25,
      side = 'left',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      float = {
        enable = false,
        open_win_config = {
          relative = 'editor',
          border = 'rounded',
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = true,
      highlight_git = false,
      full_name = false,
      highlight_opened_files = 'none',
      special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md', 'CMakeLists.txt' },
      symlink_destination = true,
      indent_markers = {
        enable = true,
        icons = {
          corner = '└ ',
          edge = '│ ',
          item = '│ ',
          none = '  ',
        },
      },
      root_folder_label = ':.:s?.*?/..?',
      icons = {
        webdev_colors = true,
        git_placement = 'before',
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        padding = ' ',
        symlink_arrow = ' 󰁔 ',
        glyphs = {
          default = icons.documents.Default, --
          symlink = icons.documents.Symlink, --
          bookmark = icons.ui.Bookmark,
          git = {
            unstaged = icons.git.Mod_alt,
            staged = icons.git.Add, --󰄬
            unmerged = icons.git.Unmerged,
            renamed = icons.git.Rename, --󰁔
            untracked = icons.git.Untracked, -- "󰞋"
            deleted = icons.git.Remove, --
            ignored = icons.git.Ignore, --◌
          },
          folder = {
            arrow_open = icons.ui.ArrowOpen,
            arrow_closed = icons.ui.ArrowClosed,
            default = icons.ui.Folder,
            open = icons.ui.FolderOpen,
            empty = icons.ui.EmptyFolder,
            empty_open = icons.ui.EmptyFolderOpen,
            symlink = icons.ui.SymlinkFolder,
            symlink_open = icons.ui.FolderOpen,
          },
        },
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    filters = {
      dotfiles = false,
      custom = { '.DS_Store' },
      exclude = {},
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
      },
      open_file = {
        quit_on_open = true,
        resize_window = false,
        window_picker = {
          enable = true,
          chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
          exclude = {
            filetype = { 'notify', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
            buftype = { 'terminal', 'help' },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      debounce_delay = 50,
      icons = {
        hint = icons.diagnostics.Hint_alt,
        info = icons.diagnostics.Information_alt,
        warning = icons.diagnostics.Warning_alt,
        error = icons.diagnostics.Error_alt,
      },
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
    },
    git = {
      enable = true,
      ignore = true,
      show_on_dirs = true,
      timeout = 400,
    },
    trash = {
      cmd = 'gio trash',
      require_confirm = true,
    },
    live_filter = {
      prefix = '[FILTER]: ',
      always_show_folders = true,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
  })
end
return config

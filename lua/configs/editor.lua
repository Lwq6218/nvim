local M = {}

M.yazi = {
  -- if you want to open yazi instead of netrw, see below for more info
  open_for_directories = false,
  floating_window_scaling_factor = 0.6,
  yazi_floating_window_winblend = 0,
  -- highlight buffers in the same directory as the hovered buffer
  highlight_groups = {
    hovered_buffer = nil,
    hovered_buffer_in_same_directory = nil,
  },
  yazi_floating_window_border = "rounded",
  keymaps = {
    show_help = "<f1>",
    open_file_in_vertical_split = "<c-v>",
    open_file_in_horizontal_split = "<c-h>",
    open_file_in_tab = "<c-t>",
    grep_in_directory = "<c-s>",
    replace_in_directory = "<c-g>",
    cycle_open_buffers = "<tab>",
    copy_relative_path_to_selected_files = "<c-y>",
    send_to_quickfix_list = "<c-q>",
    change_working_directory = "<c-\\>",
  },
}

M.snacks = {
  notifier = { enabled = true, reflesh = 120, margin = { top = 5, right = 2, bottom = 0 } },
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  indent = {
    enabled = true,
    indent = { char = " ", only_scope = true, only_current = true },
    filter = function(buf)
      local exclude = { "help" }
      return vim.g.snacks_indent ~= false
        and vim.b[buf].snacks_indent ~= false
        and vim.bo[buf].buftype == ""
        and not vim.tbl_contains(exclude, vim.bo[buf].filetype)
    end,
  },
  input = { enabled = true },
  picker = { enabled = true },
  toggle = { enabled = true },
  win = { enabled = true },
  words = { enabled = false },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  styles = {
    zen = {
      keys = { q = "close" },
    },
    notification = {
      border = "rounded",
    },
    notification_history = {
      border = "signle",
    },
  },
}
M.trouble = {
  win_config = {
    winblend = 0,
  },
  modes = {
    lsp = {
      win = { position = "left" },
    },
    symbols = {
      win = {
        type = "split", -- split window
        relative = "win", -- relative to current window
        position = "left", -- right side
        size = 0.3, -- 30% of the window
      },
    },
  },
}
return M

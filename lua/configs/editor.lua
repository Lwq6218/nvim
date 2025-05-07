local M = {}

M.yazi = {
  -- if you want to open yazi instead of netrw, see below for more info
  open_for_directories = false,
  floating_window_scaling_factor = 0.5,
  yazi_floating_window_winblend = 0,
  use_ya_for_events_reading = false,
  -- highlight buffers in the same directory as the hovered buffer
  highlight_hovered_buffers_in_same_directory = false,
  highlight_groups = {
    -- See https://github.com/mikavilpas/yazi.nvim/pull/180
    hovered_buffer = nil,
    -- See https://github.com/mikavilpas/yazi.nvim/pull/351
    hovered_buffer_in_same_directory = nil,
  },
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
  -- 👇 if you use `open_for_directories=true`, this is recommended
  -- init = function()
  --   -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
  --   -- vim.g.loaded_netrw = 1
  --   vim.g.loaded_netrwPlugin = 1
  -- end,
}
M.snacks = {
  notifier = { enabled = true, reflesh = 120, margin = { top = 5, right = 2, bottom = 0 } },
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  win = { enabled = true },
  words = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  picker = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
  styles = {
    zen = {
      keys = { q = "close" },
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

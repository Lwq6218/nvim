local M = {}

---@type table
M.nvim_tree = {
  update_focused_file = {
    enable = true,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
    custom = { ".git", ".cache" },
  },
  view = {
    -- hide_root_folder = true,
    adaptive_size = true,
  },
  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      local tree_wins = {}
      local floating_wins = {}
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:match "NvimTree_" ~= nil then
          table.insert(tree_wins, w)
        end
        if vim.api.nvim_win_get_config(w).relative ~= "" then
          table.insert(floating_wins, w)
        end
      end
      if 1 == #wins - #floating_wins - #tree_wins then
        -- Should quit, so we close all invalid windows.
        for _, w in ipairs(tree_wins) do
          vim.api.nvim_win_close(w, true)
        end
      end
    end,
  }),
}
M.yazi = {
  -- if you want to open yazi instead of netrw, see below for more info
  open_for_directories = false,
  floating_window_scaling_factor = 0.9,
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
    open_file_in_horizontal_split = "<c-x>",
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
  words = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  picker = { enabled = false },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = false },
}
return M

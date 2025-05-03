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
}
return M

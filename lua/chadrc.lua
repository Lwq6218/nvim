-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

local M = {}
M.base46 = {
  theme = "catppuccin",
  transparency = false,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    "                            ",
    "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    "   ▄▀███▄     ▄██ █████▀    ",
    "   ██▄▀███▄   ███           ",
    "   ███  ▀███▄ ███           ",
    "   ███    ▀██ ███           ",
    "   ███      ▀ ███           ",
    "   ▀██ █████▄▀█▀▄██████▄    ",
    "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    "                            ",
    "     Powered By  eovim    ",
    "                            ",
  },

  buttons = {
    { txt = "  Find File", keys = "f", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "o", cmd = "Telescope oldfiles" },
    { txt = "  Find Text", keys = "g", cmd = "Telescope live_grep" },
    { txt = "  Config", keys = "c", cmd = ":e $MYVIMRC" },
    { txt = "  Mappings", keys = "m", cmd = "NvCheatsheet" },
    { txt = "󱥚  Themes", keys = "t", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "󰒲  Lazy", keys = "l", cmd = "Lazy" },
    { txt = "  Quit", keys = "q", cmd = "qa" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}
M.ui = {
  telescope = { style = "bordered" }, -- borderless / bordered

  cmp = {
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      lsp = true,
    },
  },

  statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    separator_style = "block",
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "encoding", "eol", "lsp", "cwd", "cursor" },
    modules = {
      encoding = function()
        if vim.list_contains({ "help" }, vim.bo.filetype) then
          return ""
        end
        local encoding = vim.bo.fileencoding:upper()
        if encoding == "" then
          return ""
        end
        return " %*" .. encoding .. " " -- "%*" is used to clear highlight group (use default highlight)
      end,
      eol = function()
        if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
          return ""
        end
        if vim.list_contains({ "help", "terminal", "NvimTree", "nvdash" }, vim.bo.filetype) then
          return ""
        end
        -- LF, CRLF or CR
        local file_format = vim.bo.fileformat
        local eol
        if file_format == "unix" then
          eol = "LF"
        elseif file_format == "dos" then
          eol = "CRLF"
        elseif file_format == "mac" then
          eol = "CR"
        end
        return " %*" .. eol .. " " -- "%*" is used to clear highlight group (use default highlight)
      end,
    },
  },

  tabufline = {
    enabled = false,
    lazyload = false,
  },
}

return M

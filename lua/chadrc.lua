-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
local M = {}
M.base46 = {
  theme = "rosepine",
  theme_toggle = { "rosepine", "github_light" },
  transparency = true,
  integrations = { "trouble", "flash", "navic" },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  hl_add = {
    -- 统一 Trouble.nvim 窗口背景
    TroubleNormal = { bg = "black" }, -- 活动状态
    TroubleNormalNC = { bg = "black" }, -- 非活动状态
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
    "     Powered By  nvchad    ",
    "                            ",
  },
  buttons = {
    { txt = "  Search File", keys = "f", cmd = ":Telescope find_files" },
    { txt = "  Recent Files", keys = "r", cmd = ":Telescope oldfiles" },
    { txt = "  Find Text", keys = "g", cmd = ":Telescope live_grep" },
    {
      txt = "  Config",
      keys = "c",
      cmd = ": cd ~/.config/nvim | lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath 'config' })",
    },
    { txt = "  Mappings", keys = "m", cmd = "NvCheatsheet" },
    { txt = "󱥚  Themes", keys = "t", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "󰒲  Lazy", keys = "l", cmd = ":Lazy" },
    { txt = "  Quit", keys = "q", cmd = ":qa" },
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
    enabled = false,
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
    lazyload = true,
  },
}

M.colorify = {
  enabled = true,
  mode = "virtual", -- fg, bg, virtual
  virt_text = "󱓻 ",
  highlight = { hex = true, lspvars = true },
}

M.cheatsheet = {
  enabled = false,
  theme = "grid", -- simple/grid
  excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
}

M.term = {
  base46_colors = true,
  winopts = { number = false },
  sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "rounded",
  },
}
M.lsp = {
  signature = false,
}
M.mason = {
  -- Use names from mason.nvim
  -- For example, if you want to install "tsserver" you should use "typescript-language-server" in the list below
  pkgs = {

    -- GoLand
    "goimports",
    "gofumpt",
    "gomodifytags",
    "impl",
    "gopls",

    -- Lua
    "lua-language-server",
    "stylua",

    -- Bash
    "bash-language-server",
    "shellcheck",
    "shfmt",

    -- Python
    "pyright",
    "ruff",

    -- TypeScript
    "vtsls",
    "css-lsp",
    "json-lsp",
    "tailwindcss-language-server",
    "prettierd",
    "eslint_d",

    -- Markdown
    "marksman",
    "markdownlint-cli2",
    "markdown-toc",
  },
  skip = {},
}

return M

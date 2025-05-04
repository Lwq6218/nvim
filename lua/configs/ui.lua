local M = {}

M.noice = {
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
    format = {
      cmdline = { pattern = "", icon = "󱐌 :", lang = "vim" },
      help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰮦 :" },
      search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = "/", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = " $ :", lang = "bash" },
      lua = {
        pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
        icon = "  :",
        lang = "lua",
      },
      input = { view = "cmdline_input", icon = " 󰥻 :" }, -- Used by input()
    },
  },
  views = {
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
    mini = {
      size = {
        width = "auto",
        height = "auto",
        max_height = 15,
      },
      position = {
        row = -2,
        col = "100%",
      },
      win_options = {
        winblend = 0, -- Set winblend to 0 for the mini view
      },
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  lsp = {
    progress = {
      enabled = false,
    },
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },

  health = {
    checker = true,
  },
  messages = {
    enabled = false,
  },
  popupmenu = {
    enabled = true,
  },
  notify = {
    enalbed = false,
  },
  signature = {
    enabled = false,
  },
}
return M

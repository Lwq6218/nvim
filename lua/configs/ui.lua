local M = {}

M.noice = {
  presets = {
    command_palette = false,
    lsp_doc_border = {
      views = {
        hover = {
          border = {
            style = "rounded",
          },
        },
      },
    },
  },
  messages = {
    enabled = false,
  },
  popupmenu = {
    enabled = false,
  },
  lsp = {
    signature = {
      enabled = false,
    },
    progress = {
      enabled = false,
    },
    hover = {
      enabled = false,
    },
  },
}
return M

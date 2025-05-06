return {
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lsp"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
}

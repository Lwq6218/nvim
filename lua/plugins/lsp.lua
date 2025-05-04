return {
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ui.border = "rounded"
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require "configs.lsp"
    end,
  },
}

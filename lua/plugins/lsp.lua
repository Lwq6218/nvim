return {
  {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lsp"
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    config = function()
      dofile(vim.g.base46_cache .. "navic")
      require("nvim-navic").setup {
        highlight = true,
        lsp = { auto_attach = true },
      }
    end,
    init = function()
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },
}

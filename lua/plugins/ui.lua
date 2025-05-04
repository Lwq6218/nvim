return {
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = function()
      return require("configs.ui").noice
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "typicode/bg.nvim",
    lazy = false,
    cond = not vim.g.neovide,
  },
}

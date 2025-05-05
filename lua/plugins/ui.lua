return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  {
    "folke/noice.nvim",
    lazy = true,
    enabled = true,
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    opts = require("configs.ui").noice,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "typicode/bg.nvim",
    lazy = false,
    enabled = true,
    cond = not vim.g.neovide,
  },
}

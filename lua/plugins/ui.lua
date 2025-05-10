return {

  {
    "folke/noice.nvim",
    enabled = false,
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    opts = require("configs.ui").noice,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },
}

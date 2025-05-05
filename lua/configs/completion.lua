local M = {}

M.blink = {

  keymap = {
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
  },

  cmdline = {
    completion = {
      menu = {
        auto_show = function(ctx)
          return vim.fn.getcmdtype() == ":"
          -- enable for inputs as well, with:
          -- or vim.fn.getcmdtype() == '@'
        end,
      },
    },
    keymap = {
      ["<CR>"] = { "select_and_accept", "fallback" },
    },
  },

  sources = {
    providers = {
      cmdline = {
        min_keyword_length = function(ctx)
          -- when typing a command, only show when the keyword is 3 characters or longer
          if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
            return 3
          end
          return 0
        end,
      },
    },
  },
}

return M

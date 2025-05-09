local M = {}

M.lint = {
  linters = {
    -- -- Example of uing selene only when a selene.toml file is present
    -- selene = {
    --   -- `condition` is another LazyVim extension that allows you to
    --   -- dynamically enable/disable linters based on the context.
    --   condition = function(ctx)
    --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
    --   end,
    -- },
  },
  linters_by_ft = {
    markdown = { "markdownlint-cli2" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    -- Use the "*" filetype to run linters on all filetypes.
    -- ['*'] = { 'global linter' },
    -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
    -- ['_'] = { 'fallback linter' },
    -- ["*"] = { "typos" },
  },
}
M.render_markdown = {
  code = {
    sign = false,
    width = "block",
    right_pad = 1,
  },
  heading = {
    sign = false,
    icons = {},
  },
  checkbox = {
    enabled = false,
  },
}
M.falsh = {

  jump = {
    autojump = true,
  },
  modes = {
    char = {
      autohide = true,
    },
  },
  exclude = {
    "notify",
    "cmp_menu",
    "noice",
    "lazy",
    "flash_prompt",
    function(win)
      -- exclude non-focusable windows
      return not vim.api.nvim_win_get_config(win).focusable
    end,
  },
  prompt = {
    prefix = { { "", "FlashPromptIcon" } },
  },
}
return M

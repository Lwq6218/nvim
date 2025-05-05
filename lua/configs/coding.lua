local M = {}

M.conform = {
  formatters_by_ft = {
    bash = { "shellcheck", "shfmt" },
    sh = { "shellcheck", "shfmt" },
    zsh = { "shellcheck" },
    c = { "clang-format", lsp_format = "last" },
    cpp = { "clang-format", lsp_format = "last" },
    javascript = { "prettierd", "eslint_d" },
    javascriptreact = { "prettierd", "eslint_d" },
    typescript = { "prettierd", "eslint_d" },
    typescriptreact = { "prettierd", "eslint_d" },
    vue = { "prettierd", "eslint_d" },
    css = { "prettierd" },
    go = { "goimports", "gofumpt" },
    html = { "prettierd" },
    java = { "google-java-format" },
    lua = { "stylua" },
    ["markdown"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
    ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    rust = { "rustfmt" },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_format = "fallback",
  },
}

M.lint = {
  linters = {
    -- -- Example of using selene only when a selene.toml file is present
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

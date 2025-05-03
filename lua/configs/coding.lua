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
    go = { "goimports", "gofmt" },
    html = { "prettierd" },
    java = { "google-java-format" },
    ksh = { "shellcheck", "shfmt" },
    lua = { "stylua" },
    mksh = { "shellcheck", "shfmt" },
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

M.lint = function()
  local lint = require "lint"
  lint.linters_by_ft = {
    markdown = { "markdownlint" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  }
  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      if vim.opt_local.modifiable:get() then
        lint.try_lint()
      end
    end,
  })
end

return M

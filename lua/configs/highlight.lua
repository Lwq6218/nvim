local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "diff",
    -- Nvim
    "lua",
    "luadoc",
    "query",
    "vim",
    "vimdoc",
    -- Markdown
    "markdown",
    "markdown_inline",
    -- React
    "html",
    "css",
    "json",
    "javascript",
    "typescript",
    "tsx",
    -- Goland
    "go",
    "gomod",
    "gowork",
    "gosum",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  disable = function(lang, bufnr)
    return lang == "yaml" and vim.api.nvim_buf_line_count(bufnr) > 5000
  end,
  -- Autoinstall languages that are not installed
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { "ruby" },
  },
  indent = { enable = true, disable = { "ruby" } },
}
return M

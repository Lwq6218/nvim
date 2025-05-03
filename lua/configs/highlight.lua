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
    "gosum"
  },
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

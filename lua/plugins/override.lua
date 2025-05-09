-- override nvchad plugins
return {
  --disable nvchad plugins
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "folke/which-key.nvim",
    enabled = true,
    opts = {
      preset = "helix",
      win = {
        border = "rounded",
      },
      spec = {
        {
          mode = { "n" },
          { "<leader>f", group = "file/find" },
        },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    keys = {
      {
        "<leader>e",
        mode = { "n", "v" },
        "<cmd>NvimTreeToggle<cr>",
        desc = "Open NvimTRee at the current file",
      },
    },
    opts = {
      update_focused_file = {
        enable = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
        custom = { ".git", ".cache" },
      },
      view = {
        -- hide_root_folder = true,
        adaptive_size = true,
      },
      init = function()
        vim.api.nvim_create_autocmd("QuitPre", {
          callback = function()
            local tree_wins = {}
            local floating_wins = {}
            local wins = vim.api.nvim_list_wins()
            for _, w in ipairs(wins) do
              local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
              if bufname:match "NvimTree_" ~= nil then
                table.insert(tree_wins, w)
              end
              if vim.api.nvim_win_get_config(w).relative ~= "" then
                table.insert(floating_wins, w)
              end
            end
            if 1 == #wins - #floating_wins - #tree_wins then
              -- Should quit, so we close all invalid windows.
              for _, w in ipairs(tree_wins) do
                vim.api.nvim_win_close(w, true)
              end
            end
          end,
        })
      end,
    },
  },

  -- Change nvchad plugins
  -- init.lua:
  {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      opts = function(_, opts)
        opts.extensions.fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        }
        require("telescope").load_extension "fzf"
      end,
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        width = 0.7,
        height = 0.7,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Esc>"] = require("telescope.actions").close,
      }
      return conf
    end,
  },
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          window = { border = "rounded" },
        },
      },
      keymap = {
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      cmdline = {
        keymap = {
          ["<CR>"] = { "accept", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        bash = { "shellcheck", "shfmt" },
        sh = { "shellcheck", "shfmt" },
        zsh = { "shellcheck" },
        javascript = { "prettierd", "eslint_d" },
        javascriptreact = { "prettierd", "eslint_d" },
        typescript = { "prettierd", "eslint_d" },
        typescriptreact = { "prettierd", "eslint_d" },
        css = { "prettierd" },
        go = { "goimports", "gofumpt" },
        html = { "prettierd" },
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
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
    },
  },
}

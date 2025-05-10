-- override nvchad plugins
return {
  --disable nvchad plugins
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  {
    "folke/which-key.nvim",
    enabled = true,
    opts = {
      preset = "helix",
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      spec = {
        { "<leader>f", group = "[F]ind" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
      win = {
        border = "rounded",
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
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end, { desc = "Jump to next git [c]hange" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end, { desc = "Jump to previous git [c]hange" })

        -- Actions
        -- visual mode
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "git [s]tage hunk" })
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end, { desc = "git [r]eset hunk" })
        -- normal mode
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
        map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "git [u]ndo stage hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
        map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
        map("n", "<leader>hD", function()
          gitsigns.diffthis "@"
        end, { desc = "git [D]iff against last commit" })
        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
        map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<Esc>"] = require("telescope.actions").close,
      }
      conf.extensions.fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      }
      pcall(require("telescope").load_extension, "fzf")

      -- See `:help telescope.builtin`
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]find [F]iles" })
      vim.keymap.set("n", "<leader>fW", builtin.grep_string, { desc = "[F]ind current [W]ord" })
      vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "[F]ind by [G]rep" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent Files" })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
      end, { desc = "[F]ind [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("c", "<leader>fc", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "[F]ind [N]eovim files" })
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
          window = { border = "rounded", scrollbar = false },
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

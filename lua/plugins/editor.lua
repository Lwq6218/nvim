return {
  { -- Override `nvim-tree` plugin
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    enabled = false,
    keys = {
      {
        "<leader>e",
        mode = { "n", "v" },
        "<cmd>NvimTreeToggle<cr>",
        desc = "Open yazi at the current file",
      },
    },
    opts = require("configs.editor").nvim_tree,
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require "grug-far"
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
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
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/snacks.nvim",
    },
    keys = {
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<leader>e",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      floating_window_scaling_factor = 0.9,
      yazi_floating_window_winblend = 0,
      use_ya_for_events_reading = false,
      -- highlight buffers in the same directory as the hovered buffer
      highlight_hovered_buffers_in_same_directory = false,
      highlight_groups = {
        -- See https://github.com/mikavilpas/yazi.nvim/pull/180
        hovered_buffer = nil,
        -- See https://github.com/mikavilpas/yazi.nvim/pull/351
        hovered_buffer_in_same_directory = nil,
      },
      keymaps = {
        show_help = "<f1>",
        open_file_in_vertical_split = "<c-v>",
        open_file_in_horizontal_split = "<c-x>",
        open_file_in_tab = "<c-t>",
        grep_in_directory = "<c-s>",
        replace_in_directory = "<c-g>",
        cycle_open_buffers = "<tab>",
        copy_relative_path_to_selected_files = "<c-y>",
        send_to_quickfix_list = "<c-q>",
        change_working_directory = "<c-\\>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    -- init = function()
    --   -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    --   -- vim.g.loaded_netrw = 1
    --   vim.g.loaded_netrwPlugin = 1
    -- end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require "harpoon"
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = true, reflesh = 120 },
      quickfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
    init = function()
      ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
      local progress = vim.defaulttable()
      vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
          if not client or type(value) ~= "table" then
            return
          end
          local p = progress[client.id]

          for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
              p[i] = {
                token = ev.data.params.token,
                msg = ("[%3d%%] %s%s"):format(
                  value.kind == "end" and 100 or value.percentage or 100,
                  value.title or "",
                  value.message and (" **%s**"):format(value.message) or ""
                ),
                done = value.kind == "end",
              }
              break
            end
          end

          local msg = {} ---@type string[]
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, p)

          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and " "
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })
    end,
  },
}

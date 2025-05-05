local servers = {
  -- GoLand
  goimports = {},
  gofumpt = {},
  gomodifytags = {},
  impl = {},
  gopls = {
    cmd = { "gopls", "-remote.debug=:0", "-remote=auto" },
    filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    capabilities = {
      textDocument = {
        completion = {
          contextSupport = true,
          dynamicRegistration = true,
          completionItem = {
            commitCharactersSupport = true,
            deprecatedSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            snippetSupport = true,
            documentationFormat = { "markdown", "plaintext" },
            resolveSupport = {
              properties = {
                "documentation",
                "details",
                "additionalTextEdits",
              },
            },
          },
        },
      },
    },
    settings = {
      gopls = {
        staticcheck = true,
        semanticTokens = true,
        usePlaceholders = true,
        completeUnimported = true,
        symbolMatcher = "Fuzzy",
        buildFlags = { "-tags", "integration" },
        semanticTokenTypes = { string = false },
        codelenses = {
          generate = true,
          gc_details = true,
          test = true,
          tidy = true,
          vendor = true,
          regenerate_cgo = true,
          upgrade_dependency = true,
        },
      },
    },
  },
  -- Python
  pyright = {},
  ruff = {},
  -- TypeScript
  vtsls = {
    -- explicitly add default filetypes, so that we can extend
    -- them in related extras
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
  cssls = {},
  jsonls = {},
  tailwindcss = {},
  prettierd = {},
  eslint_d = {},

  -- Bash
  bashls = {
    filetypes = { "sh", "zsh", "bash" },
  },
  shfmt = {},

  -- Lua
  lua_ls = {},
  stylua = {},

  -- Markdown
  marksman = {},
  ["markdownlint-cli2"] = {},
  ["markdown-toc"] = {},
}
local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"
local ooo = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  -- map HERE
end

local ensure_installed = vim.tbl_keys(servers or {})
require("mason-tool-installer").setup { ensure_installed = ensure_installed }

---@type lspconfig.Config
local default_lspconfig_setup_options = {
  on_attach = ooo,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

require("mason-lspconfig").setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    ---@param server_name string
    function(server_name)
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.lsp").diagnostic_config()
      local server = servers[server_name] or {}
      ---@diagnostic disable-next-line: undefined-field
      lspconfig[server_name].setup(vim.tbl_deep_extend("force", default_lspconfig_setup_options, server))
    end,
    lua_ls = function()
      dofile(vim.g.base46_cache .. "lsp")
      require("nvchad.lsp").diagnostic_config()
      local settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = { disable = { "missing-fields" } },
        },
      }
      ---@diagnostic disable-next-line: undefined-field
      lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default_lspconfig_setup_options, {
        settings = settings,
      }))
    end,
  },
}

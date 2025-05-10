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
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = { disable = { "missing-fields" } },
        hint = {
          enable = true,
        },
      },
    },
  },
  stylua = {},

  -- Markdown
  marksman = {},
  ["markdownlint-cli2"] = {},
  ["markdown-toc"] = {},
}
dofile(vim.g.base46_cache .. "lsp")
local nvlsp = require "nvchad.configs.lspconfig"

local custom_on_attach = function(client, buf)
  -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
  end

  map("K", function()
    vim.lsp.buf.hover { border = "rounded" }
  end, "LSP show details")
  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map("grn", require "nvchad.lsp.renamer", "Rename")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("gra", vim.lsp.buf.code_action, "Goto Code Action", { "n", "x" })

  -- Find references for the word under your cursor.
  map("grr", require("telescope.builtin").lsp_references, "Goto References")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gri", require("telescope.builtin").lsp_implementations, "Goto Implementation")

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map("grd", require("telescope.builtin").lsp_definitions, "Goto Definition")

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("grD", vim.lsp.buf.declaration, "Goto Geclaration")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("grt", require("telescope.builtin").lsp_type_definitions, "Goto Type Definition")

  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, buf) then
    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
      end,
    })
  end
  -- The following code creates a keymap to toggle inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client:supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf })
    end, "[T]oggle Inlay [H]ints")
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    custom_on_attach(client, event.buf)
  end,
})

local default_lspconfig_setup_options = {
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

for name, opts in pairs(servers) do
  vim.lsp.enable(name) -- nvim v0.11.0 or above required
  vim.lsp.config(name, vim.tbl_deep_extend("force", {}, default_lspconfig_setup_options, opts or {})) -- nvim v0.11.0 or above required
end

require("nvchad.lsp").diagnostic_config()

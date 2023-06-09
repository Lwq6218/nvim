local package = require('core.pack').package
local conf = require('modules.lsp.config')
package({
  'lvimuser/lsp-inlayhints.nvim',
  event = 'LspAttach',
  branch = 'anticonceal',
  config = function()
    vim.api.nvim_create_augroup('LspAttach_inlayhints', {})
    vim.api.nvim_create_autocmd('LspAttach', {
      group = 'LspAttach_inlayhints',
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require('lsp-inlayhints').on_attach(client, bufnr)
      end,
    })
    require('lsp-inlayhints').setup()
  end,
})

package({
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufAdd', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
    },
    {
      'williamboman/mason-lspconfig.nvim',
    },
  },
  config = conf.nvim_lsp,
})
package({
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'mason.nvim' },
  opts = function()
    local nls = require('null-ls')
    return {
      root_dir = require('null-ls.utils').root_pattern('.null-ls-root', '.neoconf.json', 'Makefile', '.git'),
      sources = {
        -- nls.builtins.formatting.fish_indent,
        -- nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        -- nls.builtins.formatting.shfmt,
        -- nls.builtins.diagnostics.flake8,
      },
    }
  end,
})

return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    require('typescript-tools').setup {
      on_attach = function()
        -- (:help typescript-tools)
        vim.keymap.set('n', '<A-o>', '<Cmd>TSToolsOrganizeImports<Cr>', { desc = 'Organize Imports' })
      end,
      filetypes = { 'typescript', 'javascript' },
    }
  end,
}

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>gq',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Format file',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function()
      return {
        timeout_ms = 500,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}

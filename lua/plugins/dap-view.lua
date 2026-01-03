return {
  {
    'igorlfs/nvim-dap-view',
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
    keys = {
      { '<F7>', function() require('dap-view').toggle() end, desc = 'Toggle debug view' },
    },
  },
}

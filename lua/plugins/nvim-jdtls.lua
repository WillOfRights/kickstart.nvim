return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  ft = { 'java' },
  config = function()
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = 'java',

      callback = function()
        local jdtls = require 'jdtls'

        local jdtls_path = '/home/will/.local/share/jdtls'
        local jar_arg = jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar'
        local config_arg = jdtls_path .. '/config_linux'

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
        local workspace_arg = vim.fn.stdpath 'data' .. '/site/java/workspace-root/' .. project_name
        os.execute('mkdir ' .. workspace_arg)

        local config = {
          -- The command that starts the language server
          -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
          cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xmx1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-jar',
            jar_arg,
            '-configuration',
            config_arg,
            '-data',
            workspace_arg,
          },

          root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),

          -- Here you can configure eclipse.jdt.ls specific settings
          -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          -- for a list of options
          settings = {
            java = {},
          },

          -- Language server `initializationOptions`
          -- You need to extend the `bundles` with paths to jar files
          -- if you want to use additional eclipse.jdt.ls plugins.
          --
          -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
          init_options = {
            bundles = { vim.fn.glob('~/CodingUtilLocal/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.2.jar', 1) },
          },
        }

        jdtls.start_or_attach(config)

        -- Keymaps
        vim.keymap.set('n', '<A-o>', jdtls.organize_imports, { desc = 'Organize Imports' })
        vim.keymap.set('n', 'crv', jdtls.extract_variable, { desc = 'Extract Variable' })
        vim.keymap.set('v', 'crv', function() jdtls.extract_variable(true) end, { desc = 'Extract Variable (visual)' })
        vim.keymap.set('n', 'crc', jdtls.extract_constant, { desc = 'Extract Constant' })
        vim.keymap.set('v', 'crc', function() jdtls.extract_constant(true) end, { desc = 'Extract Constant (visual)' })
        vim.keymap.set('v', 'crm', function() jdtls.extract_method(true) end, { desc = 'Extract Method' })
      end,
    })
  end,
}

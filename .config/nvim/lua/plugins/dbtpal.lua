return {
  {
    -- DBT parser
    'PedramNavid/dbtpal',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local dbt = require 'dbtpal'
      dbt.setup {
        -- Path to the dbt executable
        path_to_dbt = 'dotenv',

        pre_cmd_args = {
          'run',
          'dbt',
          '--use-colors',
          '--printer-width=10',
        },

        -- Path to the dbt project, if blank, will auto-detect
        -- using currently open buffer for all sql,yml, and md files
        path_to_dbt_project = '/Users/austintucker/work/repos/dbt-bigquery-dw',

        -- Path to dbt profiles directory
        path_to_dbt_profiles_dir = vim.fn.expand './',

        -- Search for ref/source files in macros and models folders
        extended_path_search = true,

        -- Prevent modifying sql files in target/(compiled|run) folders
        protect_compiled_files = true,
      }

      -- Setup key mappings

      vim.keymap.set('n', '<leader>dcp', dbt.compile)
      vim.keymap.set('n', '<leader>drf', dbt.run)
      vim.keymap.set('n', '<leader>drp', dbt.run_all)
      vim.keymap.set('n', '<leader>dtf', dbt.test)
      vim.keymap.set('n', '<leader>dm', require('dbtpal.telescope').dbt_picker)

      -- Enable Telescope Extension
      require('telescope').load_extension 'dbtpal'
    end,
  },
}

local dbt_profiles_dir = os.getenv('DBT_PROFILES_DIR') or "~/src/bi-astronomer/dags/dbt"
local dbt_project = os.getenv('DBT_PROJECT') or "~/src/bi-astronomer/dags/dbt"

return {
  {
    "PedramNavid/dbtpal",
    init = function ()
      local dbt = require('dbtpal')
      dbt.setup {
        path_to_dbt = "dbt",
        path_to_dbt_profiles_dir = dbt_profiles_dir,
        path_to_dbt_project = dbt_project,
        extended_path_search = true,
        protect_compiled_files = true
      }

      -- dbt build the model we're currently editing
      vim.keymap.set('n', '<leader>dbf', function() dbt.build("-s " .. vim.fn.expand("%:t"):gsub(".sql$", "")) end)
      vim.keymap.set('n', '<leader>dbp', function() dbt.build("-s +" .. vim.fn.expand("%:t"):gsub(".sql$", "")) end)
      vim.keymap.set('n', '<leader>dbrp', function() dbt.build("-s --full-refresh +" .. vim.fn.expand("%:t"):gsub(".sql$", "")) end)
      vim.keymap.set('n', '<leader>drf', dbt.run)
      vim.keymap.set('n', '<leader>dtf', dbt.test)
      vim.keymap.set('n', '<leader>dm', require('dbtpal.telescope').dbt_picker)

      require'telescope'.load_extension('dbtpal')
    end,
  },
}

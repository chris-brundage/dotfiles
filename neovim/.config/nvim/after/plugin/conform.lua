require('conform').setup({
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    sql = { 'sqlfluff' },
  },
  formatters = {
    sqlfluff = {
      command = vim.fn.getcwd() .. '/.venv/bin/sqlfluff',
      args = function(_, ctx)
        return { 'fix', ctx.filename }
      end,
      stdin = false,
      cwd = require("conform.util").root_file({ "dbt_project.yml", ".sqlfluff" }),
    },
  },
})

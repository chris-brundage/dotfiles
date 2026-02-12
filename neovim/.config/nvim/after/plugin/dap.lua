require('dap-python').setup(os.getenv("HOME") .. "/.local/share/nvim/mason/bin/debugpy-adapter")

local dap = require('dap')

table.insert(dap.configurations.python, {
  type = "python",
  request = "attach",
  name = "Attach to Airflow Docker",
  connect = {
    host = "127.0.0.1",
    port = 5678,
  },
  pathMappings = {
    {
      localRoot = vim.fn.getcwd() .. "/dags",
      remoteRoot = "/opt/airflow/dags",
    },
    {
      localRoot = vim.fn.resolve(os.getenv("HOME") .. "/.pyenv/versions/airflow/lib/python3.11/site-packages"),
      remoteRoot = "/home/airflow/.local/lib/python3.11/site-packages",
    }
  },
  justMyCode = false,
})

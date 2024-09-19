dap_python = require("dap-python")

dap_python.setup("python")
dap_python.resolve_python = function ()
  if vim.fn.executable("pyenv") then
    return io.popen("pyenv which python")
  end

  if os.getenv("VIRTUALENV") then
    return os.getenv("VIRTUALENV")
  end

  if os.getenv("PYTHON_PATH") then
    return os.getenv("PYTHON_PATH")
  end

  if vim.fn.isdirectory(".venv") then
    return ".venv/bin/python"
  end
end

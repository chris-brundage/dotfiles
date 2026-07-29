local M = {}

-- Handle poetry path shenanigans where needed
function M.get_poetry_path()
  if vim.fn.executable('poetry') == 0 then
    return "python"
  end

  local handle = io.popen('poetry env info --path 2>/dev/null')
  if handle then
    local path = handle:read("*a")
    handle:close()
    path = path:gsub("%s+", "")
    if path ~= "" then
      return path .. "/bin/python"
    end
  end

  return "python"
end

return M

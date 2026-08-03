local M = {}

-- Handle poetry path shenanigans where needed
function M.get_poetry_path(dir)
  if vim.fn.executable('poetry') == 0 then
    return "python"
  end

  local cmd = 'poetry env info ' .. '-C ' .. vim.fn.shellescape(dir) .. ' --path 2>/dev/null'

  local handle = io.popen(cmd)
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

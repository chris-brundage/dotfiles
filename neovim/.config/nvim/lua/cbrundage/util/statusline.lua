local M = {}

local has_git = vim.fn.executable("git") == 1

-- Truncate paths if the total string length exceeds this percentage of the window size
local PATH_WIDTH_PERCENT = 0.25

local function truncate_path(path, max_len)
  if #path <= max_len then
    return path
  end

  local segments = vim.split(path, "/", { plain = true })
  if #segments <= 2 then
    return path
  end

  local repo_name = segments[1]
  local tail_segments = {}
  local tail_len = 0
  local budget = max_len - #repo_name - #"/.../"

  for i = #segments, 2, -1 do
    local seg = segments[i]
    local added_len = #seg + 1
    if tail_len + added_len > budget then
      break
    end
    table.insert(tail_segments, 1, seg)
    tail_len = tail_len + added_len
  end

  if #tail_segments == 0 then
    table.insert(tail_segments, segments[#segments])
  end

  return repo_name .. "/.../" .. table.concat(tail_segments, "/")
end

-- raw (untruncated) git-relative path, expensive to compute, so it's cached
local function compute_git_relative_path(bufnr)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then
    return "[No Name]"
  end

  if not has_git then
    return vim.fn.fnamemodify(filepath, ":t")
  end

  local dir = vim.fn.fnamemodify(filepath, ":h")
  local result = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })

  if vim.v.shell_error == 0 and result[1] then
    local git_root = result[1]
    local parent = vim.fn.fnamemodify(git_root, ":h")
    return filepath:sub(#parent + 2)
  else
    return vim.fn.fnamemodify(filepath, ":t")
  end
end

function M.git_relative_filename()
  local bufnr = vim.api.nvim_get_current_buf()
  if not vim.b[bufnr].git_relative_path then
    vim.b[bufnr].git_relative_path = compute_git_relative_path(bufnr)
  end

  local win_width = vim.api.nvim_win_get_width(0)
  local max_len = math.floor(win_width * PATH_WIDTH_PERCENT)

  local path = truncate_path(vim.b[bufnr].git_relative_path, max_len)

  if vim.bo[bufnr].modified then
    path = path .. " [+]"
  end
  if vim.bo[bufnr].readonly then
    path = path .. " [RO]"
  end

  return path
end

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "BufWritePost" }, {
  callback = function(args)
    vim.b[args.buf].git_relative_path = nil
  end,
})

return M

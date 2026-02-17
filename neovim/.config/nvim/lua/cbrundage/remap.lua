vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle relativenumber on and off
vim.keymap.set('n', '<C-n><C-n>', function()
  local option_value = vim.api.nvim_get_option_value('relativenumber', {})
  vim.api.nvim_set_option_value('relativenumber', not option_value, {})
end)

-- Search for files using fzf
vim.keymap.set('n', '<leader>b', '<cmd>Files<cr>', {})

-- Grep!
vim.keymap.set('n', '<leader>ss', '<cmd>Rg<cr>', {})
vim.keymap.set('n', '<leader>SS', '<cmd>RG<cr>', {})
vim.keymap.set('n', '<leader>gf', '<cmd>GFiles<cr>', { desc = 'Search [G]it [F]iles' })

-- Thanks Primeagen
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set('x', '<leader>p', [["_dP]])

-- dap
vim.keymap.set({ 'n' }, '<leader>dp', function()
  require('dap').continue()
end)
vim.keymap.set({ 'n' }, '<leader>dt', function() require('dapui').toggle() end)

-- Cycle through buffers
vim.keymap.set({ 'n' }, '<leader>Bn', '<cmd>bnext<cr>')
vim.keymap.set({ 'n' }, '<leader>Bp', '<cmd>bprevious<cr>')
vim.keymap.set({ 'n' }, '<leader>Bd', '<cmd>bdelete<cr>')

vim.keymap.set('n', '<leader>ex', function() require('oil').open() end)

local function split_term(cmd)
  vim.cmd("FloatermNew --position=below " .. cmd)
end

vim.keymap.set('n', '<leader>drf', function()
  local model = vim.fn.expand("%:t:r")
  split_term("dbt run -s " .. model)
end, { desc = "dbt run (current model)" })

vim.keymap.set('n', '<leader>dbd', function()
  local model = vim.fn.expand("%:t:r")
  split_term("dbt build -s " .. model .. "+")
end, { desc = 'dbt build (current + downstream)' })

vim.keymap.set('n', '<leader>dbu', function()
  local model = vim.fn.expand("%:t:r")
  split_term("dbt build -s " .. "+" .. model)
end, { desc = 'dbt build (current + upstream)' })

vim.keymap.set('n', '<leader>dbf', function()
  local model = vim.fn.expand("%:t:r")
  split_term("dbt build -s " .. model)
end, { desc = 'dbt build (current model)' })

vim.keymap.set('n', '<leader>dbc', function()
  local model = vim.fn.expand("%:t:r")
  split_term("dbt compile -s " .. model)
end, { desc = 'dbt compile (current model)' })

vim.keymap.set('n', '<leader>dbs', function()
  local model = vim.fn.expand("%:t:r")
  local dbt_root = vim.fs.find("dbt_project.yml", {
    upward = true,
    path = vim.fn.expand("%:p:h"),
  })
  if #dbt_root > 0 then
    local root = vim.fn.fnamemodify(dbt_root[1], ":h")
    local compiled = root .. "/target/compiled/cmg_data/models/**/" .. model .. ".sql"
    local files = vim.fn.glob(compiled, false, true)
    if #files > 0 then
      vim.cmd("vsplit " .. files[1])
    else
      vim.notify("Compiled SQL not found. Run dbt compile first.", vim.log.levels.WARN)
    end
  end
end, { desc = 'Show compiled SQL' })

vim.keymap.set('n', '<leader>dgd', function()
  -- Get word under cursor or try to extract from ref('...')
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")
  local ref_match = line:match("ref%('([%w_]+)'%)")
  local source_match = line:match("source%('[%w_]+',%W?'([%w_]+)'%)")
  local model = ref_match or source_match
  if model then
    -- Search for the file in the project
    local dbt_root = vim.fs.find("dbt_project.yml", {
      upward = true,
      path = vim.fn.expand("%:p:h"),
    })
    if #dbt_root > 0 then
      local root = vim.fn.fnamemodify(dbt_root[1], ":h")
      local files = vim.fn.globpath(root .. "/models", "**/" .. model .. ".sql", false, true)
      if #files > 0 then
        vim.cmd("edit " .. files[1])
      else
        vim.notify("Model not found: " .. model, vim.log.levels.WARN)
      end
    end
  else
    vim.notify("No ref() or source() found on this line", vim.log.levels.INFO)
  end
end, { desc = 'Go to ref/source model' })

vim.keymap.set('n', '<leader>dba', function()
  split_term("dbt build")
end, { desc = 'dbt run (all)' })

vim.keymap.set('n', '<leader>dbs', function()
  local model = vim.fn.expand("%:t:r")
  local progress = require("fidget.progress")
  local handle = progress.handle.create({
    title = "dbt show",
    message = model,
    lsp_client = { name = "dbt" },
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("dbt show failed: " .. result, vim.log.levels.ERROR)
    return
  end

  vim.system(
    { "sh", "-c", [[dbt show -s ]] ..
    model .. [[ -q --output json --limit 500 | jq -c '{keys: (.show[0] | keys_unsorted), rows: .show}']] },
    { text = true },
    function(obj)
      vim.schedule(function()
        if obj.code ~= 0 then
          handle:cancel()
          vim.notify("dbt show failed: " .. (obj.stderr or ""), vim.log.levels.ERROR)
          return
        end

        handle:finish()

        local data = vim.json.decode(obj.stdout)
        local rows_data = data.rows
        local column_names = data.keys

        -- calculate max width for each column
        local widths = {}
        for _, k in ipairs(column_names) do
          widths[k] = #k
        end
        for _, row in ipairs(rows_data) do
          for _, k in ipairs(column_names) do
            local val = row[k]
            local str = (val == vim.NIL or val == nil) and "NULL" or tostring(val)
            widths[k] = math.max(widths[k], #str)
          end
        end

        -- build header
        local header_parts = {}
        for _, k in ipairs(column_names) do
          table.insert(header_parts, k .. string.rep(" ", widths[k] - #k))
        end
        local header = "│ " .. table.concat(header_parts, " │ ") .. " │"

        -- build separator line
        local sep_parts = {}
        for _, k in ipairs(column_names) do
          table.insert(sep_parts, string.rep("─", widths[k]))
        end
        local separator = "├─" .. table.concat(sep_parts, "─┼─") .. "─┤"
        local top_border = "┌─" .. table.concat(sep_parts, "─┬─") .. "─┐"
        local bottom_border = "└─" .. table.concat(sep_parts, "─┴─") .. "─┘"

        -- build rows
        local rows = { top_border, header, separator }
        for _, row in ipairs(rows_data) do
          local parts = {}
          for _, k in ipairs(column_names) do
            local val = row[k]
            local str = (val == vim.NIL or val == nil) and "NULL" or tostring(val)
            table.insert(parts, str .. string.rep(" ", widths[k] - #str))
          end
          table.insert(rows, "│ " .. table.concat(parts, " │ ") .. " │")
        end
        table.insert(rows, bottom_border)

        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, rows)
        vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
        vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

        vim.cmd("below split")
        vim.api.nvim_set_current_buf(buf)
        vim.api.nvim_set_option_value("wrap", false, { win = 0 })
      end)
    end
  )
end)

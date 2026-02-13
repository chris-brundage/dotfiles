-- Auto-detect dbt project sql files and add jinja highlighting
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.sql",
  callback = function()
    -- Check if we're in a dbt project (has dbt_project.yml somewhere above)
    local dbt_root = vim.fs.find("dbt_project.yml", {
      upward = true,
      path = vim.fn.expand("%:p:h"),
    })
    if #dbt_root > 0 then
      vim.bo.commentstring = "{# %s #}"
    end
  end,
})

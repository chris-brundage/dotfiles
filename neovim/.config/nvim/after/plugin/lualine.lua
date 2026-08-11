require("lualine").setup({
  sections = {
    lualine_c = {
      function()
        return require("cbrundage.util.statusline").git_relative_filename()
      end,
    },
  },
  inactive_sections = {
    lualine_c = {
      function()
        return require("cbrundage.util.statusline").git_relative_filename()
      end,
    },
  },
})

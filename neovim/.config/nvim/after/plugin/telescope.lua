local builtin = require('telescope.builtin')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    path_display = { "truncate" }
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
      hijack_netrw = true
    }
  }
}

-- Extensions
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'aerial')
pcall(require('telescope').load_extension, 'project')
pcall(require('telescope').load_extension, 'file_browser')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>b', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>ss', builtin.live_grep, { desc = '[S]earch [S]tring' })
vim.keymap.set('n', '<leader>SS', function()
  builtin.live_grep({ additional_args = { '--fixed-strings', '--case-sensitive' } })
end, { desc = 'Literal string match' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

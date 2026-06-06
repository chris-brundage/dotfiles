vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>FloatermToggle<cr>')

vim.g.floaterm_height = 0.95
vim.g.floaterm_width = 0.95

-- Termsize sets 140x50
-- Termsize 140 sets width to 140
-- Termsize 140 50 sets 140x50
vim.api.nvim_create_user_command('Termsize', function(opts)
  local args = vim.split(opts.args, '%s+', { trimempty = true })
  local width = args[1] or '140'
  local height = args[2] or '50'
  vim.cmd('FloatermUpdate --width=' .. width .. ' --height=' .. height)
end, { nargs = '*' })

vim.keymap.set('n', '<leader>ts', '<cmd>Termsize<cr>', { desc = 'Resize Floaterm' })

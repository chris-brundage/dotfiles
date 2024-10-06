if vim.g.vscode then
  do return end
end

require('toggleterm').setup {}

vim.keymap.set('n', '<leader>tt', vim.cmd.ToggleTerm)
vim.keymap.set('n', '<leader>ftt', function() vim.cmd.ToggleTerm("direction='float'") end)

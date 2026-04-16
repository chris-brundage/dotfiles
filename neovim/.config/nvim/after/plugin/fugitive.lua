if vim.g.vscode then
    do return end
end

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>ga', vim.cmd.Gwrite)
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<CR>')
vim.keymap.set('n', '<leader>gP', '<cmd>Git pull<CR>')
vim.keymap.set('n', '<leader>gb', vim.cmd.GBrowse)

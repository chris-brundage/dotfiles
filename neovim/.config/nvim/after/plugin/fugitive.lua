if vim.g.vscode then
    do return end
end

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>ga', vim.cmd.Gwrite)
-- vim.keymap.set('n', '<leader>gc', vim.cmd('Git commit'))

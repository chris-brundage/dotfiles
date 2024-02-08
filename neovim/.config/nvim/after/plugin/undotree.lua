if vim.g.vscode then
    do return end
end

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

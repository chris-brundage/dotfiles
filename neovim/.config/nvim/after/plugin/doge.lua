if vim.g.vscode then
    do return end
end

vim.keymap.del('n', '<leader>d', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>dg', '<Plug>(doge-generate)', {silent = true})

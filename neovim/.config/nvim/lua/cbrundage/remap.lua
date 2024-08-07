vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle relativenumber on and off
vim.keymap.set('n', '<C-n><C-n>', function ()
    local option_value = vim.api.nvim_get_option_value('relativenumber', {})
    vim.api.nvim_set_option_value('relativenumber', not option_value, {})
end)

-- Search for files using fzf
vim.keymap.set('n', '<leader>b', '<cmd>Files<cr>', {})

-- Grep!
vim.keymap.set('n', '<leader>ss', '<cmd>Rg<cr>', {})
vim.keymap.set('n', '<leader>gf', '<cmd>GFiles<cr>', { desc = 'Search [G]it [F]iles' })

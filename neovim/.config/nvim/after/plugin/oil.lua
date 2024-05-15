local oil = require('oil')

oil.setup({
  view_options = {
    show_hidden = true,
  }
})

-- Allow my muscle memory from netrw to still work
vim.api.nvim_create_user_command('Ex', function ()
  oil.open(vim.fn.expand('%:p:h'))
end, {})

vim.api.nvim_create_user_command('Vex', function ()
  vim.cmd('vsp ' .. vim.fn.expand('%:p:h'))
end, {})

vim.api.nvim_create_user_command('Hex', function ()
  vim.cmd('sp ' .. vim.fn.expand('%:p:h'))
end, {})

vim.keymap.set('n', '<leader>b', '<cmd>Oil --float<cr>', {})

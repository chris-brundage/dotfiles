local oil = require('oil')

oil.setup({
  view_options = {
    show_hidden = true,
  }
})

vim.keymap.set('n', '<leader>ee', function() oil.open(vim.fn.expand('%p:h')) end)
vim.keymap.set('n', '<leader>eh', function() vim.cmd('sp ' .. vim.fn.expand('%:p:h')) end)
vim.keymap.set('n', '<leader>ev', function() vim.cmd('vsp ' .. vim.fn.expand('%:p:h')) end)

-- Allow my muscle memory from netrw to still work
vim.api.nvim_create_user_command('Ex', function(cmd_args)
  local dir = string.len(cmd_args['args']) > 0 and cmd_args['args'] or '%:p:h'

  oil.open(vim.fn.expand(dir))
end, { nargs = '?', complete = 'dir' })

vim.api.nvim_create_user_command('Vex', function(cmd_args)
  local dir = string.len(cmd_args['args']) > 0 and cmd_args['args'] or '%:p:h'

  vim.cmd('vsp ' .. vim.fn.expand(dir))
end, { nargs = '?', complete = 'dir' })

vim.api.nvim_create_user_command('Hex', function(cmd_args)
  local dir = string.len(cmd_args['args']) > 0 and cmd_args['args'] or '%:p:h'

  vim.cmd('sp ' .. vim.fn.expand(dir))
end, { nargs = '?', complete = 'dir' })

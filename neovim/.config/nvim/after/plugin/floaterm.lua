local floaterm = require('floaterm')

vim.keymap.set('n', '<leader>tt', function ()
  floaterm.toggle()
end)

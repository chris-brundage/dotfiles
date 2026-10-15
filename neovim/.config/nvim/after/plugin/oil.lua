local oil = require('oil')

oil.setup({
  view_options = {
    show_hidden = true,
  },
})

-- Open oil in the current window, or in a new split
local function open_oil(split, dir)
  if split then
    vim.cmd[split]()
  end
  oil.open(dir)
end

-- Keymaps
vim.keymap.set('n', '<leader>ee', function() open_oil() end, { desc = 'Oil: current dir' })
vim.keymap.set('n', '<leader>eh', function() open_oil('split') end, { desc = 'Oil: hsplit' })
vim.keymap.set('n', '<leader>ev', function() open_oil('vsplit') end, { desc = 'Oil: vsplit' })

-- Allow my muscle memory from netrw to still work
local function make_cmd(name, split)
  vim.api.nvim_create_user_command(name, function(cmd_args)
    local dir = cmd_args.args ~= '' and vim.fn.expand(cmd_args.args) or nil
    open_oil(split, dir)
  end, { nargs = '?', complete = 'dir' })
end

make_cmd('Ex', nil)
make_cmd('Vex', 'vsplit')
make_cmd('Hex', 'split')

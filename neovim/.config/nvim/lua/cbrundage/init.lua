require('cbrundage.set')
require('cbrundage.remap')
require('cbrundage.lazy')

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--
-- Gentoo specific stuff
--
local gentoo_group = vim.api.nvim_create_augroup('Gentoo', { clear = true })

local portage_conf_dir = '/etc/portage'
for _, event in pairs({ 'BufRead', 'BufNewFile' }) do
  -- Ensure config files in /etc/portage get treated as such
  vim.api.nvim_create_autocmd(event, {
    pattern = { portage_conf_dir .. '/package.*' },
    callback = function()
      vim.opt.filetype = 'conf'
    end,
    group = gentoo_group
  })

  -- Same for bashrc files in /etc/portage
  vim.api.nvim_create_autocmd(event, {
    pattern = { portage_conf_dir .. '*bashrc', portage_conf_dir .. '/env/*' },
    callback = function()
      vim.opt.filetype = 'bash'
    end,
    group = gentoo_group
  })
end
--
-- End Gentoo stuff
--

vim.cmd [[colorscheme catppuccin-mocha]]

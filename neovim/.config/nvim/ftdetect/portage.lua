local portage_conf_dir = '/etc/portage/'

vim.filetype.add({
  pattern = {
    [portage_conf_dir .. 'package.*'] = 'conf',
    [portage_conf_dir .. '.*bashrc'] = 'bash',
    [portage_conf_dir .. 'env/.*'] = 'bash'
  }
})

local homedir = os.getenv('HOME')

vim.filetype.add({
  pattern = {
    ['.*/%.github/.*%.yml'] = { 'yaml', { priority = 10 } },
    [homedir .. '/src/mf%-ansible/.*.yml'] = 'yaml.ansible',
    [homedir .. '/src/sinch%-mg%-infrastructure/ansible/.*.yml'] = 'yaml.ansible'
  }
})

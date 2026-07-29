local homedir = os.getenv('HOME')

vim.filetype.add({
  pattern = {
    [homedir .. '/src/mf%-ansible/.*.yml'] = 'yaml.ansible',
    [homedir .. '/src/sinch%-mg%-infrastructure/ansible/.*.yml'] = 'yaml.ansible'
  }
})

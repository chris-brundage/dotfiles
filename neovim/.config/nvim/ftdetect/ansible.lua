local homedir = os.getenv('HOME')

vim.filetype.add({
  pattern = {
    [homedir .. '/src/mf%-ansible/.*.yml'] = 'yaml.ansible'
  }
})

local homedir = os.getenv('HOME')

vim.filetype.add({
  pattern = {
    ['.*.nomad'] = 'hcl',
    [homedir .. '/src/mf%-terragrunt/.*.hcl'] = 'terraform'
  }
})

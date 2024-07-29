return {
  "junegunn/fzf",
  dependencies = { "junegunn/fzf.vim" },
  build = {
    ":call fzf#install()"
  }
}

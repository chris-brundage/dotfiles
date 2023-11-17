set nocompatible
set history=50
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoindent
inoremap <C-U> <C-G>u<C-U>
set modeline

"set term=builtin_ansi
syntax on
set hlsearch
set invnumber
set relativenumber
set number
"filetype plugin indent on
nmap <C-N><C-N> :set invnumber<CR>
set expandtab       " convert tabs to spaces
set tabstop=4       " 4 spaces to a tab
set shiftwidth=4    " 4 spaces for indentation

set termguicolors

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd BufNewFile,BufRead *.eyaml set syntax=yaml tabstop=2 shiftwidth=2
endif

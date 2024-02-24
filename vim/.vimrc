set nocompatible
syntax on
set history=50
set ruler
set showcmd
set modeline

set expandtab
set tabstop=4
set shiftwidth=4

set incsearch
set autoindent

set invnumber
set relativenumber
set number
set colorcolumn=80
highlight ColorColumn ctermbg=235 guibg=#31353f

set mouse=a
set termguicolors
set clipboard=unnamed

let g:netrw_banner=0

" Toggle relativenumber on and off
function! ToggleRelativeNumber()
    if &relativenumber ==# 1
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

nmap <C-N><C-N> :call ToggleRelativeNumber()<CR>
inoremap <C-U> <C-G>u<C-U>

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd BufNewFile,BufRead *.eyaml set syntax=yaml tabstop=2 shiftwidth=2
endif

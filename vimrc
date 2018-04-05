execute pathogen#infect()
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Bundle 'chase/vim-ansible-yaml'
Bundle 'Valloric/YouCompleteMe'
call vundle#end()

syntax on
filetype indent plugin on
autocmd FileType yaml set indentkeys-=<:>
syntax enable

set ruler
set number
set ic
set mouse=a
set hidden

map <C-A> 0|

" Solarized stuff
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

let g:go_disable_autoinstall = 0

" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let python_highlight_all=1

"split navigations
nnoremap <C-R> <C-W><C-L>
nnoremap <C-E> <C-W><C-H>

" Python indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
au BufNewFile,BufRead *.py
    \ set shiftwidth=4
au BufNewFile,BufRead *.py
    \ set softtabstop=4
au BufNewFile,BufRead *.py
    \ set textwidth=99
au BufNewFile,BufRead *.py
    \ set autoindent
au BufNewFile,BufRead *.py
    \ set expandtab
au BufNewFile,BufRead *.py
    \ set fileformat=unix
"NERDTree keymap
"  "=============
nnoremap <C-Q> :NERDTreeToggle<CR>
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"File Browsing
"============
nnoremap l <C-e>
nnoremap k <C-y>

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
	:NERDTreeTabsClose
	set mouse=
	set nonu
	set paste
    else
        " enable mouse everywhere
        set mouse=a
	set nu
	:NERDTreeTabsOpen
    endif
endfunc

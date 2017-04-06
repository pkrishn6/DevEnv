execute pathogen#infect()
syntax on
filetype plugin indent on
syntax enable

set ruler
set number
set ic
map <C-E> $
map <C-A> 0|

let g:go_disable_autoinstall = 0

" Highlight
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"NERDTree keymap
"  "=============
nmap <leader>' :NERDTreeToggle <CR>

"File Browsing
"============
nnoremap l <C-e>
nnoremap k <C-y>

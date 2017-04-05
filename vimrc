"==============================================================================
"Pathogen
"==============================================================================
execute pathogen#infect()
syntax on
filetype plugin indent on
"==============================================================================
"coding standard guidelines.
"==============================================================================
set shiftwidth=4 tabstop=4
set softtabstop=4
set expandtab
set textwidth=80                "line width
set autoindent
set smartindent
set cindent


"==============================================================================
"Vim settings
"==============================================================================
set ruler                       "disply the row col number in the task bar
"set ic                          "ignore case in search
set laststatus=2                "status bar on always
set showtabline=2               "tab bar on alwasy
set splitright                  "new window alwasys on right
set wildmenu                    "smart cmd completion option on status bar
set autoindent                  "next line starts in the same point
set incsearch                   "highlights search patter while typing pattern
set hlsearch                    "highlights all the search pattern
set tagstack                    "control t and ] for tags.
set guioptions-=T               "disable the tools bar for gvim
set ch=1                        "set the command line high
set tabpagemax=10               "set tab limits
set fillchars+=vert:\           "set the vertical split without any char
set cursorline                  "higlight the cursor line
"set number                     "show line number
set wildignore+=*.o,*.obj,*.so  "ignore these files

set filetype=on

"==============================================================================
"Plugins (~sridharp/.vim/plugin)
"==============================================================================
"Tlist
"cscopeMenu
"cscope_win
"MRU
"NERDtree
"conque_term
"colorscheme mirodark

"MRU function keys
"=================
"o          Open file under curser in the MRU window
"t          Open file under curser in new tab
"v          Open file under curser in viewonly mode
"q          quit
"MRU pat    list only the file that matches pat

"NERDtree function keys
"======================
"q          quit
"t          open in a new tab
"T          preveiw in new tab
"i gi       open/preview in horizontal split
"s gs       open/preview in vertical split
"I          List the hidden files(like .vimrc) (toggle)
"F          List files (toggle)
"B          list bookmark (toggle)
"A          maximize/minimize Nerdtree window (toggel)
"o O        open the dir/Recursivly
"x X        close the dir/Recursivly
"<C j>      go to next siblings
"<C k>      go to privious siblings
"r R        refresh current/root

"NERDTree keymap
"=============
nmap <leader>' :NERDTreeToggle <CR>

"==============================================================================
"Cscope stuffs"
"==============================================================================
"set csprg=~/bin/cscope
cs add $WS_BASE_/$BR_INFO_DIR/cscope.out $WS_BASE_
set tags=$WS_BASE_/$BR_INFO_DIR/tags
set cscopetag

set csto=0                      "Search cscope first then tags, (1 otherwise)
set cspc=8                      "don't list full file path in cscope results
set cscopeverbose               "show msg when any other cscope db added

"==============================================================================
"Key maps
"==============================================================================
"		0 or s: Find this C symbol
"		1 or g: Find this definition
"		2 or d: Find functions called by this function
"		3 or c: Find functions calling this function
"		4 or t: Find this text string
"		6 or e: Find this egrep pattern
"		7 or f: Find this file
"		8 or i: Find files #including this file

nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>


nmap <C-\>[ :Ggrep <cword><CR><CR>
autocmd QuickFixCmdPost *grep* cwindow
"File Browsing
"============
nnoremap ; j
nnoremap j k
nnoremap l <C-e>
nnoremap k <C-y>
"nnoremap L <C-f>
"nnoremap K <C-b>
nmap L <C-f>
nmap K <C-b>

"nnoremap <C-l> <C-f>
"nnoremap <C-k> <C-b>
"Marks
"=====
nnoremap = `

" Windows
" =======
nmap <leader>v :vsplit <CR>
nmap <leader>h :split <CR>

nmap <C-\>f :echo expand('%:p')<CR>
nmap <C-\>r :so ~/.vimrc<CR>

"CommandT
"============
"Default map
"\t for CommandT
"C-c to close the CommandT
"tab to switch between search and result

"Fugitive
"========
nmap <C-\>b :Gblame<CR>

"Gundo
"=====
nmap <leader>u :GundoToggle<CR>

"Tlist keymap
"=============
nmap <leader>] :TagbarToggle<CR><CR>

"MRU keymap
"=============
nmap <leader>/ :MRU <CR>

"Conque term keymap
"==================
nmap <C-\>t :ConqueTermTab bash <CR>
nmap <C-\>v :ConqueTermVSplit bash <CR>

" FULL SCREEN for ubuntu
" ======================
map <silent> <C-F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" Stripping white space
" =====================
function! g:FixFormat()
    :StripWhitespace
    :retab
endfunction
command! FixF call g:FixFormat()
nmap <C-\>w :FixF<CR>
"nmap <C-\>w :StripWhitespace <CR><CR>

"==============================================================================
"Setting Fonts
"==============================================================================
if has("gui_running")
    if has("gui_gtk2")
        " Ubuntu laptop case
        set guifont=Courier\ New\ 9
        "set guifont=ProggyCleanTT\ 6
    elseif has("x11")
       " set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-*
         set guifont=-ibm-courier-medium-r-normal--10-0-0-0-m-0-ascii-0
       " set guifont=-ibm-courier-medium-r-normal--16-0-0-0-m-0-ascii-0
    else
        "set guifont=Courier_New:h11:cDEFAULT
        "set guifont=-ibm-courier-medium-r-normal--16-0-0-0-m-0-ascii-0
        set guifont=-ibm-courier-medium-r-normal--10-0-0-0-m-0-ascii-0
    endif
endif

"==============================================================================
"Set the colour here...!
"==============================================================================
"colorscheme solarized
set background=dark
set t_Co=256
syntax enable

func! Cleanup()
    :delmarks a-z
    :delmarks A-Z
    echo "Goodbye!"
endf

func! Startup()
    :tab all
    echo "Hello Prasanna!"
endf

:auto VimLeave * call Cleanup()
":auto VimEnter * call Startup()
nmap <leader>q :qa! <CR><CR>

" Mouse support
if has("mouse")
    set mouse=a
    set mousehide
endif

"fix the cursor for tmux
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"Toggle between zoom
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-z> :ZoomToggle<CR>

function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    setlocal colorcolumn=80
    let &colorcolumn=join(range(81,999),",")
  endif
endfunction
command! ToggleCC call g:ToggleColorColumn()<CR>
nnoremap <silent> <C-\>p :ToggleCC <CR>

" GO STUFF TODO
" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

let g:go_gotags_bin = '/home/spitchai/gotool/bin/gotags'
let ctagsbin = 'gotags'
" check if vim-go is available and has the binary
if !executable('gotags') && !exists("g:go_gotags_bin")
let ctagsbin = expand(g:go_gotags_bin),
endif
let g:tagbar_type_go = {
    \'ctagstype' : 'go',
    \'kinds' : ['p:package','i:imports:1','c:constants','v:variables','t:types','n:interfaces',
        \'w:fields','e:embedded','m:methods','r:constructor','f:functions'
        \],
    \'sro' : '.',
    \'kind2scope' : {'t' : 'ctype','n' : 'ntype'},
    \'scope2kind' : {'ctype' : 't','ntype' : 'n'},
    \'ctagsbin' : expand(g:go_gotags_bin),
    \'ctagsargs' : '-sort -silent'
    \}


" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>
let g:syntastic_go_checkers = ['golint']
let g:ycm_confirm_extra_conf = 0
let g:go_fmt_command = "gofmt"

"Tab Navigation
"==============
":tabs         list all tabs including their displayed windows
":tabm 0       move current tab to first
":tabm         move current tab to last
":tabm {i}     move current tab to position i+1
"
":tabn         go to next tab
":tabp         go to previous tab
":tabfirst     go to first tab
":tablast      go to last tab
"In normal mode, you can type:
"
"gt            go to next tab
"gT            go to previous tab
"{i}gt         go to tab in position i

:tab all
nmap <leader>n :tab split <CR><CR>
nmap <leader>i :tabs <CR>
nmap <leader>= :tabnew <CR><CR>
nmap <leader>- :tabclose <CR><CR>
nmap  <C-l> :tabn<CR>
nmap  <C-k> :tabp<CR>
nmap <End>  :tabn <CR><CR>
nmap <Home> :tabp <CR><CR>
nmap 11 :tabn 1 <CR>
nmap 22 :tabn 2 <CR>
nmap 33 :tabn 3 <CR>
nmap 44 :tabn 4 <CR>
nmap 55 :tabn 5 <CR>
nmap 66 :tabn 6 <CR>
nmap 77 :tabn 7 <CR>
nmap 88 :tabn 8 <CR>
nmap 99 :tabn 9 <CR>
nmap <PageUp>   :tabn <CR><CR>
nmap <PageDown> :tabp <CR><CR>


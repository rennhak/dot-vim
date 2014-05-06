" File :  ~/.vimrc
"
" Vim Configuration File
"
" Author(s) : Bjoern Rennhak <vimrc@rennhak.com>
" Licence :   GPLv2, MIT, BSD triple licensed
"
"

" Let's define specific TODO colors
" http://dtuite.github.com/define-custom-vim-tags-and-labels.html
if !exists("autocmd_colorscheme_loaded")
  let autocmd_colorscheme_loaded = 1

  autocmd ColorScheme * highlight TodoRed      ctermbg=Red guibg=#002b37 ctermfg=White     guifg=#E01B1B
  autocmd ColorScheme * highlight TodoOrange   ctermbg=Yellow guibg=#002b37 ctermfg=Black guifg=#E0841B
  autocmd ColorScheme * highlight TodoYellow   ctermbg=Green guibg=#002b37 ctermfg=Black  guifg=#E0D91B
endif

"set cscopetag
set tags=./ctags.out

"C-] - go to definition
"C-T - Jump back from the definition.
"C-W C-] - Open the definition in a horizontal split
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"C-\ - Open the definition in a new tab
"A-] - Open the definition in a vertical split

" This lags in file movement -- why??
" set cul
"

set fenc=utf-8
set vb t_vb=
set ww=b,s,<,>,[,]
set sel=exclusive
set slm=mouse,key
set km=startsel,stopsel
set ul=1000
set bs=indent,eol,start
set ru
syn on
set ai ai
set laststatus=2
set ts=2
set sw=2
set sta sta
set visualbell
set foldcolumn=3
set foldmethod=marker
set tabstop=2
set autoindent
set filetype=on
set nowrap
set wrapmargin=100
set textwidth=100

set expandtab
set shiftwidth=2
set list listchars=tab:»·,trail:· 

"if has("gui_running")
"    colorscheme zenburn
"    "colorscheme baycomb
"    "colorscheme koehler
"    "set guifont=Terminus:8
"    set gfn=Terminus\ 6
"    set guioptions-=T           " turn off toolbar
"    set guioptions-=r           " turn off scrollbar
"    set guioptions-=m           " turn off menu
"    "set guioptions=aiAc
"else
    set t_Co=256
    "set t_AB=^[[48;5;%dm
    "set t_AF=^[[38;5;%dm
    set background=dark
    " <cool>
    "colorscheme ps_color
    colorscheme symfony
    "colorscheme solarized
    "colorscheme herald
    " </cool>
    "colorscheme gentooish
    "colorscheme ir_black
    "colorscheme herald
    "colorscheme vibrantink
    "colorscheme zenburn
    "colorscheme darkZ
     "colorscheme baycomb
"endif

hi FoldColumn ctermbg=4
hi Folded ctermbg=4

" Abbreviations
"ab #b /*********************************************************
"ab #e *********************************************************/
"ab #l /* ---------------------------------------------------- */
"ab #i \item[-]
"ab ... <!-- }}}1 --><ESC><HOME>/\d<CR>h
"ab ,,, <!-- {{{1 --><ESC><HOME>/\d<CR>h

" select all in normal mode
noremap <F11> gggH<C-O>G

" set paste toggle to F12
set pastetoggle=<F12>

" integer++
noremap ] <C-A>

" integer--
noremap [ <C-X>

" hightlights shortly the braces when you type them
set showmatch

" shows the hightlight for tenth of sec
set mat=5

" sets cindent mode others are ai (autoindent), si (smart indent)
set ai
set si
set cindent

" use tab at beginning of the line spaces elsewhere
" set smarttab

" highlight perl adv. vars inside strings
let perl_extended_vars=1

"remember  autoformat badly formatted code (-> v j = )

" hightlight trailing whitesspaces and tabs
set list listchars=trail:.
highlight SpecialKey ctermfg=DarkGrey

" list tabs

" set list listchars=tab:\|_,trail:.
" 
" ctrl + n  -> keyword completetion.
" normal mode, K over a keyword goes to manpage..

" no vi compat please
set nocompatible

" share clipboard with x
set clipboard+=unnamed

" load filetype plugins
filetype plugin on

" these are not word diveders so don't try to divide them
set isk+=_,$,@,%,#,-

" show line numbers
set number

" backspace works normal now
set backspace=2

" use mouse everywhere
set mouse=a

" keep ten lines top/bottom for scope
set so=10

" SuperReTab (see google)
" select range then :SuperRetab($width)
"function! SuperRetab(width) range
"		silent!  exe a:firstline . ',' . a:lastline . 's/\v%(^ *)@<= {' . a:width . '}/\t/g'
"endfunction

" function! SuperRetab(width) range
" 		let @" = ''
" 		redir @"
" 		while @" !~ 'E486:'
" 		silent! exe a:firstline . ',' . a:lastline . 'g/^\([ ]*\)[ ]\{' . a:width . '}/s//\1\t\2/'
" 		endwhile
" endfunction

"map <F2> <ESC>ggVG:call SuperRetab()<left>


set nocp
if version >= 600
    filetype plugin indent on
endif

" Dictionary Settings
set mouse=n
let g:spchkmouse    = 1
let g:spchkautonext = 1
let g:spchkdiablect = "usa"

map <F4> ggVGg?

filetype plugin on
filetype indent on

onoremap <silent>ai :<C-u>cal IndTxtObj(0)<CR>
onoremap <silent>ii :<C-u>cal IndTxtObj(1)<CR>
vnoremap <silent>ai <Esc>:cal IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii <Esc>:cal IndTxtObj(1)<CR><Esc>gv

function! IndTxtObj(inner)
  let i = indent(line("."))
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while (i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner)))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while (i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner)))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction 


" RSense Plugin
let g:rsenseHome = "/home/br/software/rsense"



" Punish the user if the arrow keys are used
" Disable Arrow keys
"noremap  <Up> ""
"noremap! <Up> <Esc>
"noremap  <Down> ""
"noremap! <Down> <Esc>
"noremap  <Left> ""
"noremap! <Left> <Esc>
"noremap  <Right> ""
"noremap! <Right> <Esc>


" To discipline me against using arrow keys in vim
"if exists("Abuses_loaded")
"    finish
"endif
"let Abuses_loaded = 1
"
"let s:count = 0
"let s:insults = ["YOU SUCK!","OBEY ME, INSECT!","OBEY ME, SUBSERVIENT BIOMASS!"]
"call add(s:insults,"ENGAGE IN COPROPHILIA AND THEN EXPIRE!")
"call add(s:insults,"YOU ARE NOT WORTHY OF VIM!")
"
"function <SID>punish_me()
"    let s:count = (s:count + 1) % len(s:insults)
"    echohl WarningMsg | echo s:insults[s:count] | echohl None
"endfunction

"nmap <right> :call <SID>punish_me()<CR>
"nmap <left>  :call <SID>punish_me()<CR>
"nmap <up>    :call <SID>punish_me()<CR>
"nmap <down>  :call <SID>punish_me()<CR>

set backupdir=~/.backup//
set directory=~/.backup//


" Tell vim to remember certain things when we exit
" '10 : marks will be remembered for up to 10 previously edited files
" "100 : will save up to 100 lines for each register
" :20 : up to 20 lines of command-line history will be remembered
" % : saves and restores the buffer list
" n... : where to save the viminfo files
" taken from: https://gist.github.com/955547 jreisig of js fame
set viminfo='10,\"100,:20,%,n~/.viminfo
set ruler

" TODO Colors
" http://dtuite.github.com/define-custom-vim-tags-and-labels.html
" Possible Colors
"
" Black
" DarkBlue
" DarkGreen
" DarkCyan
" DarkRed
" DarkMagenta
" Brown, DarkYellow
" LightGray, LightGrey, Gray, Grey
" DarkGray, DarkGrey
" Blue, LightBlue
" Green, LightGreen
" Cyan, LightCyan
" Red, LightRed
" Magenta, LightMagenta
" Yellow, LightYellow
" White


if has("autocmd")
  if v:version > 701
     autocmd Syntax * call matchadd('TodoRed',  '\W\zs\(TODO1\)')
     autocmd Syntax * call matchadd('TodoOrange', '\W\zs\(TODO2\)')
     autocmd Syntax * call matchadd('ToDoYellow', '\W\zs\(TODO3\)')
   endif
endif


" Comments on visual selected block
map ,#  :s/^/#/<CR> <Esc>:nohlsearch <CR>
map ,/  :s/^/\/\//<CR> <Esc>:nohlsearch <CR>
map ,>  :s/^/> /<CR> <Esc>:nohlsearch<CR>
map ,"  :s/^/\"/<CR> <Esc>:nohlsearch<CR>
map ,%  :s/^/%/<CR> <Esc>:nohlsearch<CR>
map ,!  :s/^/!/<CR> <Esc>:nohlsearch<CR>
map ,;  :s/^/;/<CR> <Esc>:nohlsearch<CR>
map ,-  :s/^/--/<CR> <Esc>:nohlsearch<CR>
map ,c  :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR> <Esc>:nohlsearch<CR>

" wrapping comments
map ,*  :s/^\(.*\)$/\/\* \1 \*\//<CR> <Esc>:nohlsearch<CR>
map ,(  :s/^\(.*\)$/\(\* \1 \*\)/<CR><Esc>:nohlsearch <CR>
map ,<  :s/^\(.*\)$/<!-- \1 -->/<CR> <Esc>:nohlsearch<CR>
map ,d  :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR> <Esc>:nohlsearch<CR>


" Mutt interface for mailtemplates inspired by 
"  git clone git://git.madduck.net/madduck/pub/code/mailplate.git
nmap <buffer> <F10>      :w<CR>:%!~/companies/asukalab/projects/work_time_email/WorkTimeEmail.rb -b<CR>
nmap <buffer> <F11>      :w<CR>:%!~/companies/asukalab/projects/work_time_email/WorkTimeEmail.rb -e<CR>




" Make sure that we have relative numbers when focused and absolute when not

" This is insanely slow, why?

"set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

"au FocusLost * :set number
"au FocusGained * :set relativenumber

"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber


" Don't screw up folds when inserting text that might affect them, until
" " leaving insert mode. Foldmethod is local to the window.
autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:last_fdm


" Visual Guide to Indentation Levels
"
" gVIM
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" Terminal
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" colorscheme desert256
" set background=dark



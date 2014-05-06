set nocompatible
set history=500
set ignorecase
set incsearch
set linebreak
set mouse=a
set ruler
set ts=4
set sw=4
set sta
set sr
set ai
set si
set nohls

set autoindent 
set cindent 
set smartindent 
set ttyfast 
set scroll=15
set smarttab 
set background=light
set background=dark
syntax on

" Don't beep or flash, please. :)
set noerrorbells
"set vb t_vb=

" avoid annoying "Hit ENTER to continue" prompts and intro-screen
"set shortmess=aI

set wildignore=*.o,*.obj,*.beam

" save file like in `borland-ides` 
nmap <F2> :w<CR>
imap <F2> <Esc>:w<CR>a

" buffer switch commands for *normal* mode
nmap <C-space><Left> :bN<CR> 
nmap <C-space><Right> :bn<CR> 
nmap <C-space><Down> :wa<CR> 
nmap <C-space><Up> :bd<CR> 

" buffer switch commands for *insert* mode
imap <C-space><Left> <Esc>:bN<CR>a
imap <C-space><Right> <Esc>:bn<CR>a
imap <C-space><Down> <Esc>:wa<CR>a
imap <C-space><Up> <Esc>:bd<CR>a
" mapping to allow keep Ctrl key presed when issuing commands
map <C-Space><C-Left> <C-Space><Left>
map <C-Space><C-Right> <C-Space><Right>
map <C-Space><C-Down> <C-Space><Down>
map <C-Space><C-Up> <C-Space><Up>

" list all buffers
nmap <C-Space><Space> :buffers<CR>
imap <C-Space><Space> <Esc>:buffers<CR>a
map <C-Space><C-Space> <C-Space><Space>


set foldnestmax=3
"set foldminlines=15
set foldmethod=marker
"set foldopen=all
"set foldclose=all
"set foldlevel=3
set foldenable

" RestorePos to last edit position, not last view
function RestorePos() 
	if line("'.") > 0
		if line("'.") <= line("$")
			exe("norm `.zz")
			if foldclosed('.') >= 0
				. foldopen
			endif
		else
			exe "norm $"
		endif
	else
		if line("'\"") > 0
			if line("'\"") <= line("$")
				exe("norm '\"zz")
				if foldclosed('.') >= 0
					. foldopen
				endif
			else
				exe "norm $"
			endif
		endif
	endif
endf

set viminfo='1000,f26,:100,\"500,@100,\/200,h,n~/.viminfo
au BufReadPost * call RestorePos()


map <F11> <C-space><Left>

map <C-Tab>	:bn<CR>
imap <C-Tab>	<Esc><C-Tab>a

map <C-S-Tab>	:bN<CR>
imap <C-S-Tab>	<Esc><C-S-Tab>a

if version >= 600
  filetype plugin on
  filetype indent on
endif

set backspace=indent,eol,start

map <F4> :WMToggle<cr>
let Tlist_Ctags_Cmd='/usr/local/bin/exctags' 
let Tlist_Compact_Format = 1
let winManagerWindowLayout='FileExplorer|TagList' 
let g:ctags_path='/usr/local/bin/exctags'
let g:ctags_title=1
let g:ctags_statusline=1 
let generate_tags=0
let g:ctags_args=''
let g:persistentBehaviour=0


colorscheme desert

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key-mappings, commands and functions
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap F1 to ":help "
nnoremap <F1> :help 
" restore visual selction after indenting
"vnoremap < <gv
"vnoremap > >gv


" Toggle fold state between closed and opened with the space bar
" If there is no fold at current line, just moves forward.
" If it is present, reverse it's state.
function! ToggleFold()
    if foldlevel('.') == 0
        normal! l
    else
        if foldclosed('.') < 0
            . foldclose
        else
            . foldopen
        endif
 endif
    " Clear status line
    echo
endfunction

"noremap <buffer> <space> :call ToggleFold()<CR>
noremap <F3> :call ToggleFold()<CR>

" Center searched result 
nmap n nzz
nmap N Nzz


" just to matching parent
set showmatch
set matchtime=2

"
"set virtualedit=all

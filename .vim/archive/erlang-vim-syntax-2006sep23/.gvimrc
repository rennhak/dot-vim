colorscheme northsky
" do not close gvim on ZZ
map ZZ :w<CR>:bd<CR>

" Run xterm on Ctrl-X 
map <C-X> :!xterm -fg green -bg black&<CR><CR>


set encoding=utf-8
set termencoding=utf-8
set guifont=Courier\ New\ 13


set fileencodings=koi8-r,cp1251,utf-8

if exists("loaded_encodingmenu")
	  aunmenu Encoding
endif

amenu &Encoding.set\ encoding\ cp1251	:set encoding=cp1251<CR>
amenu &Encoding.set\ encoding\ koi8-r	:set encoding=koi8-r<CR>
amenu &Encoding.set\ encoding\ utf-8	:set encoding=utf-8<CR>
amenu &Encoding.-SEP1-	:
amenu &Encoding.save\ as\ cp1251	:w ++enc=cp1251<CR>
amenu &Encoding.save\ as\ koi8-r	:w ++enc=koi8-r<CR>
amenu &Encoding.save\ as\ utf-8		:w ++enc=utf-8<CR>
amenu &Encoding.-SEP2-	:
amenu &Encoding.set\ file\ encoding	:let &fileencoding=&encoding<CR>



"set statusline=%<%f%h%m%r%=%b\ %{&encoding}\ 0x%B\ \ %l,%c%V\ %P
"
if !exists("loaded_encodingmenu")
  let loaded_encodingmenu=1
endif

set guioptions-=T

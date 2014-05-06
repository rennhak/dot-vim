" File: $(HOME)/.vimrc

""""
"
" (c) 2003-2014, Bjoern Rennhak
" VIM configuration file
"
" Dual licensed under MIT and GPLv2.
"
""""""""""

"""""
"
" Files/Directory Structure
"
"
" $HOME/.vimrc            VIM main config file
" $HOME/.vim              VIM standard plugins, configs, autoloads etc.
" $HOME/.vim/bundle       Pathogen bundle folder
" $HOME/.vim_public       VIM public scripts folder
" $HOME/.vim_private      VIM private configs folder
"
"
"""""""""""



"""""
"
" Public
"
"""""""""""

source $HOME/.vim_public/01_general
source $HOME/.vim_public/02_colors
source $HOME/.vim_public/03_indents
source $HOME/.vim_public/04_highlights
source $HOME/.vim_public/05_functions
source $HOME/.vim_public/06_languages
source $HOME/.vim_public/07_key_bindings


"""""
"
" Private
"
"""""""""""

" WARNING: You should comment those if you don't have or use them

source $HOME/.vim_private/01_general
source $HOME/.vim_private/02_colors


" EOF

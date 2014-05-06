" Vim compiler file
" Compiler:	    
" Maintainer:	    
" URL:		    
" Latest Revision:  
" arch-tag:	    

if exists("current_compiler")
  finish
endif
let current_compiler = "erlang"

if exists(":CompilerSet") != 2          " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

" CompilerSet makeprg=erlc\ +debug_info\ %
CompilerSet makeprg=gmake

CompilerSet errorformat=%f:%l:\ %m,
		    \%f:%l:\ Warning:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: set sts=2 sw=2:

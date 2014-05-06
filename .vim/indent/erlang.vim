"  vim: set sw=4 sts=4:
"  Maintainer	: Gergely Kontra <kgergely@mcl.hu>
"  Revised on	: 2002.02.18. 23:34:05
"  Language	: Erlang

" TODO:
"   checking with respect to syntax highlighting
"   ignoring multiline comments
"   detecting multiline strings

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif

let b:did_indent = 1

setlocal indentexpr=GetErlangIndent()
setlocal indentkeys=
"setlocal indentkeys+=0%,-,0;,>,0)

" Only define the function once.
if exists("*GetErlangIndent")
    finish
endif

let s:functiondef ='^\s*[a-zA-Z][a-zA-Z0-9_]*\s*(.*)\s*\%(when.*\)\?\s*->'

let s:fundef ='\<fun\>\s*(.*)\s*\%(when.*\)\?\s*->'

let s:blockbeg='\<case\>\s.*\s\<of\>\|\<receive\>\|\<if\>\|\<try\>\|\<fun\>'
let s:blockend='\(end\)'
let s:beflet = '^\s*\(initializer\|method\|try\)\|\(\<\(begin\|do\|else\|in\|then\|try\)\|->\|;\|(\)\s*$'

" Indent pairs
function s:FindPair(pstart, pmid, pend)
  call search(a:pend+1, 'bW')
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn'))
  ", 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|comment"'))
endfunction

function s:FindAround(pstart, pmid, pend)
  return indent(searchpair(a:pstart, a:pmid, a:pend, 'bWn'))
  ", 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\\|comment"'))
endfunction

function! GetErlangIndent()
    " Find a non-blank line above the current line.
    let pnum = prevnonblank(v:lnum - 1)
    " Hit the start of the file, use zero indent.
    if pnum == 0
       return 0
    endif
    let line = getline(v:lnum)
    let pline = getline(pnum)

    let ind = indent(pnum)
    " This line is %% or %%% comment -> use no comment
    if line =~ '^\s*%%'
		retu 0
    endif
    " Previous line was comment -> use previous line's indent
    if pline =~ '^\s*%'
		retu ind
    endif

	" Check for clause head on previous line
	if line =~ s:functiondef 
		let ind = 0
		retu int
	endif

"	" indent fun-s
"	if pline =~ s:fundef 
"		let ind = ind + &sw
"	endif

	if line =~ 'after'
		return s:FindAround('receive', '', 'end')
	endif
	
"	if pline =~ s:blockbeg
"		" keep case, receive match clauses at same level
"		retu ind
"	endif

	if line =~ '-1>'
		let ind = ind + &sw
	endif

	if pline =~ '->'
		let ind = ind + &sw
	endif

	if line =~ 'end\s*)\s*[,;\.]'
		return s:FindAround(s:blockbeg, '', 'end')
	endif

	if line =~ 'end\s*[,;\.]'
"		echo "kuku"
		return s:FindAround(s:blockbeg, '', 'end')
	endif

	if pline =~ '[;\.]\s*\(%.*\)\?$'
		let ind = ind - &sw
	endif

    return ind
endfunction

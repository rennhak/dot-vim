" commenting out with % sign at line start
" like in borland IDE's
map <C-k>[ :s/^/%/<CR>:nohlsearch<CR>
map <C-k>] :s/^%//<CR>:nohlsearch<CR>
imap <C-k>[ <Esc>:s/^/%/<CR>:nohlsearch<CR>a
imap <C-k>] <Esc>:s/^%//<CR>:nohlsearch<CR>a
map <C-k><C-[> <C-k>[
map <C-k><C-]> <C-k>]


set makeprg=gmake

"map <F9> 	:!erl -compile %<CR>
"map <F9> 	:!erlc +debug_info %<CR>
map <F9> :make<CR>
nmap <F8><F8> :wa<CR>:!exctags --languages=Erlang --recurse --exclude="*.beam"<CR><C-l>
nmap <F8> :wa<CR>:!exctags  --exclude="*.beam" *.erl *.hrl<CR><C-l>
map <F10> 	<F9>:!jerl -noshell -s %:r %:r -s init stop<CR>
map <F7> 	<F9>:!jerl -noshell -s %:r test -s init stop<CR>

" set manual folding with manual open/close
set foldmethod=marker
"set foldopen=all
"set foldclose=all
set foldlevel=0
set foldenable

" lookup item under the cursor in file and show the list of 
" entries
"
" map ctrl-enter to jump to n-th match in list (gvim)
map <C-CR> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" for vim
map ;; [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" map <Leader>l -- usally \l to display list of compile errors and
" wait for error number enter
" \= - show next error message
" \p - show previous error message 
" \b - build
map <Leader>l :cl<CR>:let nr = input("Which one: ")<Bar>exe ":cc " . nr <CR>
map <Leader>= :cn<CR>
map <Leader>p :cp<CR>
map <Leader>b :make<CR>

set commentstring=\ \%\ %s
set include=^\s*-include

if isdirectory("../include") && isdirectory("../ebin")
	let &l:path="../include"
	let moredirs = substitute(glob("../../*/include"), "\n", ",", "g")
	let &l:path = &l:path . "," . moredirs
endif


" correctly interpret erlc messages
compiler erlang

" ex typed in normal mode will show all clauses defined in
" current buffer
map ex :g/^\s*[a-zA-Z0-9_]\+(.*).*->/<CR>

"map <C-k><C-k> :exec '!lynx "`ls /usr/local/lib/erlang/lib/stdlib*/doc/html/calendar.html /usr/local/lib/erlang/lib/kernel*/doc/html/calendar.html` /home/nm/docs/php/function.'.substitute(expand("<cword>"), "_", "-", "").'.html" ' <CR><CR>:redraw<CR>


 setlocal omnifunc=erlangcomplete#Complete

" try to call mozilla to show help for current
" function
" not as usable, because you should type arity in browser line
map <C-k><C-k> :call CursorHelp()<CR>


function! RunBrowser(url) " open URL in browser
"	let CMD = "!firefox -remote 'openURL(\"file://" . a:url . "\")'"
	let CMD = "/usr/X11R6/bin/firefox-devel 'file://" . a:url . "' &"
"	echo CMD
	call system( l:CMD )
	:redraw
endfunction

func! RunBrowserFunc(url, func, arity) 
	call RunBrowser( a:url . "\#" . a:func . "/" . a:arity)
endf


function! GetFileName(command) 
	" lookup only in stdlib and kernel directories
	let BasePath = '/usr/local/lib/erlang/lib/*/doc/html/' . a:command . '.html'

	let filename = system('ls ' . BasePath)
"	echo "---> " .  BasePath . " for " . filename
	if v:shell_error > 0
		return ''
	endif
	let filename = substitute(filename, "[\r\n]*$", "", "")
	return strtrans(filename)
endf

func! GetFunArity(fileName, funcName) 
"	grep 'NAME="sort' /usr/local/lib/erlang/lib/stdlib-1.13.9/doc/html/lists.html | sed 's%^.*NAME="sort/\([0-9]*\).*$%\1%' | head -n 1

	let arity = system("grep 'NAME=\"" . a:funcName . "' " . a:fileName . "| sed 's%^.*NAME=\"" . a:funcName . "/\\([0-9]*\\).*$%\\1%' | head -n 1")

	if v:shell_error > 0
		return ''
	endif

	let arity = substitute(arity, "[\r\n]*$", "", "")

	return arity
endf


func! CursorHelp()
	let cPos = col(".")
	let funName = expand("<cword>")

	let pos = stridx(funName, ":")

	if pos == -1 
		return ''
	endif

    let moduleName = strpart(funName, 0, pos)
    let funName = strpart(funName, pos+1)

"	let funName = expand("<cword>")
"	normal 3b
"	let moduleName = expand("<cword>")
	call cursor(0, cPos)

	let fName = GetFileName(moduleName)
	if fName != ""

		let arity = GetFunArity(fName, funName)
		
		call RunBrowserFunc(fName, funName, arity)
"		echo moduleName . "->" . funName . " @ " . fName . "/" . arity
	endif

endf

function! ErlBalloonExpr()
"	return 'Cursor is at line ' . v:beval_lnum .
"	\', column ' . v:beval_col .
"	\ ' of file ' .  bufname(v:beval_bufnr) .
"	\ ' on word "' . v:beval_text . '"'

	let funName = v:beval_text

	let pos = stridx(funName, ":")

	if pos == -1 
		return ''
	endif

    let moduleName = strpart(funName, 0, pos)
    let funName = strpart(funName, pos+1)

"	let funName = expand("<cword>")
"	normal 3b
"	let moduleName = expand("<cword>")

	let fName = GetFileName(moduleName)

	if fName != ""
"		return "lynx -dump " . fName . " | grep '" . funName . ".*->'"
		let arity = system("lynx -dump " . fName . " | egrep '[ \t]+" . funName . ".*->' ")

		if v:shell_error > 0
			return ''
		endif

		"let arity = substitute(arity, "[\r\n]*$", "", "")

		return arity
"		echo moduleName . "->" . funName . " @ " . fName . "/" . arity
	endif

return ''
endfunction
set bexpr=ErlBalloonExpr()
set ballooneval


"call RunBrowser("file:///usr/local/lib/erlang/lib/stdlib-1.13.5/doc/html/gen_server.html\#call")


"noremap <buffer> <space> :call ToggleFold()<CR>


" in directory browser move this files at top
let g:explFavSuffix='.erl,.hrl'
let g:explFavSuffixFirst=1


" find if there is dictionary with erlang terms and
" set up dictionar  completition
let s:path=globpath(&runtimepath, "ftplugin/erlang_dictionary")
if s:path != "" 
	let &dictionary=s:path
	set complete+=k
	" : is also used in keywords - we need this
	"   to allow searching thru dictionary
	set iskeyword=@,48-57,_,:,192-255
endif


func! ErlTemplate(templName)
	let path=globpath(&runtimepath, "ftplugin/erlang." . a:templName . ".tmpl")
	if path != "" 
		exec "normal gg"
		exec ":0r " . path . ""
		exec ":%s/@module@/" .  expand("%:r") . "/g" 
	endif
endfunction

func! ErlTestClause()
"	let b:line_num = line(".")
	let path=globpath(&runtimepath, "ftplugin/erlang.test_clause.tmpl")
	if path != "" 
		let clause=input("Clause name:")
		exec ":r " . path . ""
		exec ":%s/@clause_name@/" .  clause . "/g" 
	endif
"	normal  line_num . "G"
endfunction

map <Leader>eserv :exec ErlTemplate("gen_server")<CR>
map <Leader>ecl   :exe ErlTestClause()<CR>


" new functionality for erlang-vim extension

let g:erl_connection = 0

func! ErlConnect() 
	exec ErlConnectI(".verl_connect")
endf

func! ErlConnectI(fileN) 
	let filename = findfile(a:fileN, ".;")
	if (filename != "") 
		try 
			exec ":source " . filename . ""
		catch
			" we have no erl extension
			return 
		endt
	endif

	try 
		let erl_file = expand("$HOME/.vim/erlang/vistel.erl")
		let beam_dir = fnamemodify(erl_file, ":h") 

		if getftime(erl_file) > getftime(beam_dir."/vistel.beam")
			" recompile vistel.erl
			let erl_connected = ErlReVistel(erl_file, beam_dir)
		else
			erlcall 'erl_connected' 'code' 'add_pathz' '["'.beam_dir.'"]'
		endif

		if (exists("erl_connected")) 
			let g:erl_connection = 1
		endif
	catch
			" we have some problems with conneting to erlang -- so 
			" disable connection
			let g:erl_connection = 0
	endt
endfunction

function! ErlReVistel(erl_file, beam_dir) 
	erlcall 'erl_connected' 'c' 'c' '["'.a:erl_file.'",[{outdir, "'.a:beam_dir.'"}, nowarn_shadow_vars] ]'
	return erl_connected
endfunction

func! ErlCheckConnect() 
	erlcall 'test' 'erlang' 'now'
	if (!exists("test")) 
		exec ErlConnectI(".verl_autoconnect")
	endif
endf

func! ErlReloadModule() 
	exec ErlCheckConnect()
	erlcall 'erltest' 'c' 'l' "[". fnamemodify(expand("%:t"), ":r") . "]"
	echo erltest
endfunction

func! ErlModPath() 
	exec ErlCheckConnect()
	let modname = fnamemodify(expand("%:t"), ":r")
	erlcall 'modpath' 'code' 'which' "[". modname . "]"
	if (exists("modpath")) 
		echo "Using " . modname . " from " . modpath
	endif
endfunction

map <Leader>c	:exe ErlConnect()<CR>
map <Leader>r	:exe ErlReloadModule()<CR>
map <Leader>w	:exe ErlModPath()<CR>

exec ErlConnectI(".verl_autoconnect")


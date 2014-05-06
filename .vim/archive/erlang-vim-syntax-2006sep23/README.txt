#
# (c) Gaspar Chilingarov 2004-2006
# contact via icq: user nm_work (leave offline message :)
# or 	  nm@web.am
#

This package includes a bunch of files to help erlang program development with
vim editor. Most commands will work in 6.3 and 6.4 versions, only one command
require 7.0 version to run. Also fixed nasty bug with breaking correct syntax 
highlighting after using $" and $% character notations.


What this package includes:
o	compiler message parsing
o	syntax highlight
o	indentation rules
o	erlang-specific macros and shortcuts
o 	2 color schemes tuned for erlang development
o 	another files :)


Please refer ls-R file for file-by-file description.

Here are useful commands which you can use editing erlang files after this package setup.

vim generic shortcuts (from .vimrc)


restoring editing position to last edit position
F2 - save file
F11 - change to next buffer
F4 - toggle explorer and tag manager
F3/Space in normal mode - toggle fold (open/close)
useful changes to n/N search commands (center search result)

gvim generic settings:
ZZ does not close gvim window - only current buffer, to close use :q
<Ctrl-X> - open xterm in current directory
<Ctrl-Space><Right> 	- change to next buffer
<Ctrl-Space><Left> 	- change to previous buffer
<Ctrl-Space><Up> 	- give UP on this buffer - close it
<Ctrl-Space><Down> 	- write DOWN this buffer to disk


erlang specific shortcuts and commands coming from .vim/ftplugin/erlang*

Commenting out with % sign at line start like in borland IDE's
<Ctrl-K>[ Comment erlang code (add one level of %)
<Ctrl+L>] Strip comments 	  (remove one level of %)


<F9> -  compile current file (see erlang.vim, and uncomment one of the possible
		cases - using make or directly calling erlc)

<Ctrl-CR> (only in gvim) or ;;  -- show all lines, where identifier under cursor is used


\l 	-	list all error and warning messages which you got from compiler and jump to one of them
\=  -   just to next error message in list
\p  -   jump to previous message in list
\b	-	run make in current dir (same as F9)

ex (in normal mode) - show list of all clauses defined in this module


Time saving shortcuts:

<Ctrl-K><Ctrl-K> 	-- launch browser with help for this function 
		if you are on Module:Function definition it will lookup Module.html under
		/usr/local/lib/erlang/lib/, and will try to jump to the Function definition.

completition functions <Ctrl-X><Ctrl-K> and possibly <Ctrl-N> or <Ctrl-P> will also lookup in 
erlang_dictionary which is distributed in this package and have function names from most of commonly used modules.

\serv 	-- will generate gen_server template code using template in ftplugin/erlang.gen_server.tmpl
\ecl    -- generat etest clause for use with test_server or simple_server


And - finally quite useful function working only in gvim 7.0 and higher - baloon evaluation expression --
if you keep cursor on system library module:function call, it will lookup arguments and return value and
show them in baloon near mouse cursor.



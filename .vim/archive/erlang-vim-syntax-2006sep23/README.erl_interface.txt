This package also provides advanced integration with vim-erlang extension,
which provides a way to run vim as an erlang node.

What do you need to get advanced features?

Follow instructions on http://zanazan.am/vim/ site to obtain patch, obtain
latest vim and recompile it with erlang support. Only UNIX users are supported
at current moment.

After compiling and installing vim with erlang support (you should check
:version in vim and see +erlang in options) you should unpack this update to
your $HOME directory.


--------------------------------------------------------------------------------
What do you need for a completition?
--------------------------------------------------------------------------------

Some functions on completition are available even if you have not yet compiled
your sources to .beam files. In other hand I greatly recommend you point vim to 
erlang system which have access to .beam files of your project and can load
them.

--------------------------------------------------------------------------------
How to tell vim connect to your erlang node?
--------------------------------------------------------------------------------

Place in directory when you will start vim file named .verl_autoconnect
with follofing line:

--cut--
erlconnect 'foonode@localhost' 'very_secret_cookie'
--cut--

It will be loaded on erlang file edit start (.erl,.hrl) and connect to your
erlang node. You may experience several common problems with erlang
distribution.

Mainly you should check that localhost is listed in ~/.hosts.erlang 
Example of my .hosts.erlang file:
--cut--
@aldan ~> cat ~/.hosts.erlang 
aldan.
localhost.
{192,168,2,185}.
--cut--

You can even tell vim connect to erlang by IP - i.e.
erlconnect 'node_name@127.0.0.1' 'cookie'

This is different from erlang-to-erlang node communication, which require exact
node names match, working resolving and etc :). C-nodes are much more simplier.

You can experience a little (2-3 seconds) delay on first startup of vim. 
It tells erlang to compile ~/.vim/erlang/vistel.erl file -- which provides
erlang side of completition support.

--------------------------------------------------------------------------------
Test you install
--------------------------------------------------------------------------------

Issue in vim following commands:

:erlcall 'foo' 'erlang' 'now'
:echo foo

You should see something like  
{'0': 1159, '1': 22239, '2': 143595} 

which is a current timestamp.


--------------------------------------------------------------------------------
Using omni-completition
--------------------------------------------------------------------------------

There are several completition modes available:

o Context-free -- at any point

	<Ctrl-X><Ctrl-O> will pop-up list of local function names, identificators and
	external modules found in erlang's path. 

	After typing several characters this list will be greatly stripped down.
	Module names coming from erlang node are marked as 'm' in list.


o External module functions
     
    If you start omni-completition after typing module_name: ,say lists:, you
	will see list of functions in that module and their possible argument
	lists-- with different arity.

	If you have typed several chars completition list will also shrink and show
	only functions with requested prefix. lists:m completition shows only
	several functions from lists module.

o  Record name completition
    
    Starting completition after # symbol will popup list of records defined or
	used in that module. Records defined in .hrl files will be marked with 'r'
	symbol in list. 

o  Record field completition

	If you are in record field context -- i.e. at the end of Var#record_name.
	expression, completition will pop-up list of fields in that record.

	Completition also works in Var#record_name{ context, but only immediatedly
	after { symbol -- we do not parse context enough to find where the record
	finishes. I hope this willbe improved soon.

o  Macro name completition

	Macro names are completed if you press <Ctrl-X><Ctrl-O> after ? sign. Only
	locally defined macros definitions are expanded -- even without looking in
	include files.



--------------------------------------------------------------------------------
Using dictionary completition
--------------------------------------------------------------------------------

	Pressing <Ctrl-N>/<Ctrl-P> will use dictionary located in ~/.vim/ftplugin/erlang.dictinary
	which holds most of the stdlib/kernel useful functions.



--------------------------------------------------------------------------------
Additional whistles and bells
--------------------------------------------------------------------------------

You can use in vim following shortcuts:

\r -- to reload module which you edit in erlang
\w -- show you which beam file are used for this 
      source file.


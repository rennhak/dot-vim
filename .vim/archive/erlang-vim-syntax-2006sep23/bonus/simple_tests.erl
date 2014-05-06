-module(simple_tests).

-export([run/1, run/2, lookup_config/2]).

-define(TIMEOUT, 10*1000).

line_logger() -> % {{{
	line_logger(nil, 0).

line_logger(Module, Line) ->
	receive 
		{ line, Mod1, Line1 } ->
			line_logger(Mod1, Line1);
		{ get, Pid } ->
			Pid ! { line, Module, Line },
			line_logger(Module, Line);
		clear ->
			line_logger();
		quit ->
			ok
	end.

line_logger_start() ->
	register(simple_tests, spawn(fun line_logger/0)).

line_logger_stop() ->
	simple_tests ! quit.

get_line() ->
	simple_tests ! { get, self() },
	receive
		{ line, Module, Line } -> { Module, Line }
	after 100 ->
		failed = notOK
	end. % }}}

run([Suite])  ->
	run(Suite);

run([Suite, Case])  ->
	run(Suite, Case);

run(Suite) when is_atom(Suite) ->
	erlang:display(Suite),
	line_logger_start(),
	run_cases(Suite),
	line_logger_stop().

run(Suite, Case) when is_atom(Suite) and is_atom(Case) -> 
	line_logger_start(),
	run_case(Suite, Case),
	line_logger_stop().

run_cases(Suite) ->
	run_cases(Suite, Suite:all(suite)).

run_cases(_Suite, []) -> ok;
run_cases(Suite, [Case|Tail]) ->
	run_case(Suite, Case),
	run_cases(Suite, Tail).

run_case(Suite, Case) ->
	process_flag(trap_exit, true),
	Pid = spawn_link(fun() -> run_spawned(Suite, Case) end),

	receive 
	{ 'EXIT', Pid, normal } -> 
		ok;
	{ 'EXIT', Pid, Reason } -> 
		io:format("FAIL: ~p:~p (at ~p) reason ~p ~n", [Suite, Case, get_line(), Reason])
	after (?TIMEOUT)*2 ->
		io:format("FAIL: ~p:~p (at ~p) - timeouted ~n", [Suite,Case, get_line()])
	end.

run_spawned(Suite, Case) ->
	InitialConfig = [],

	case code:is_loaded(Suite) of
	false -> code:load_file(Suite);
	_ -> ok
	end,

	Config = case erlang:function_exported(Suite,init_per_testcase,2) of
	true ->
		Suite:init_per_testcase(Case, InitialConfig);
	false ->
		InitialConfig
	end,

	% we do not process {skip, Reason} message for now
	process_flag(trap_exit, true),
	Pid = spawn_link(fun() -> run_test_case(Suite,Case,Config) end),
	receive 
	{ 'EXIT', Pid, normal } -> 
		io:format("PASS: ~p ~n", [Suite:Case(doc)]);
	{ 'EXIT', Pid, Reason } -> 
		io:format("FAIL: ~p (at ~p) reason ~p ~n", [Suite:Case(doc), get_line(), Reason])
	after ?TIMEOUT ->
		io:format("FAIL: ~p (at ~p) - timeouted ~n", [Suite:Case(doc), get_line()])
	end,

	process_flag(trap_exit, false),

	% we reach here without crashing, let mgr know
	% and cleanup recources
    case erlang:function_exported(Suite,fin_per_testcase,2) of
	true ->
		Suite:fin_per_testcase(Case, Config);
	false ->
		ok
	end,
	exit(normal).

run_test_case(Suite, Case, Config) ->
	Suite:Case(Config),
	ok.
	
%%% stolen from test_server
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lookup_config(Key,Config) -> {value,{Key,Value}} | undefined
%% Key = term()
%% Value = term()
%% Config = [{Key,Value},...]
%%
%% Looks up a specific key in the config list, and returns the value
%% of the associated key, or undefined if the key doesn't exist.

lookup_config(Key,Config) ->
    case lists:keysearch(Key,1,Config) of
	{value,{Key,Val}} ->
	    Val;
	_ ->
	    io:format("Could not find element ~p in Config.~n",[Key]),
	    undefined
    end.

-define(line, simple_tests ! { line, ?MODULE,?LINE }, ).
-define(config,simple_tests:lookup_config).

match(X, X) -> ok.

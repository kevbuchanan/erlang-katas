-module(myapp_test).
-include_lib("eunit/include/eunit.hrl").

simple_test() ->
    ok = application:start(myapp),
    ?assertNot(undefined == whereis(myapp_sup)).

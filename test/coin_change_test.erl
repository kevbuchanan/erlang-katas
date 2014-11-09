-module(coin_change_test).
-include_lib("eunit/include/eunit.hrl").

change_pennies_test() ->
    ?assertEqual([4, 0, 0, 0, 0], coin_change:change(4)).

change_nickels_test() ->
    ?assertEqual([3, 1, 0, 0, 0], coin_change:change(8)).

change_dimes_test() ->
    ?assertEqual([2, 1, 1, 0, 0], coin_change:change(17)).

change_quarters_test() ->
    ?assertEqual([4, 0, 2, 3, 0], coin_change:change(99)).

change_dollars_test() ->
    ?assertEqual([1, 1, 1, 1, 1], coin_change:change(141)).

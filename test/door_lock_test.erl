-module(door_lock_test).
-include_lib("eunit/include/eunit.hrl").

unlock_door() ->
    door_lock:press_button(1),
    door_lock:press_button(2),
    door_lock:press_button(3),
    door_lock:press_button(4),
    door_lock:press_button(5).

locked_test() ->
    {Reply, _} = door_lock:start_link([1, 2, 3, 4, 5]),
    ?assertEqual(ok, Reply),
    {State, _} = door_lock:get_state(),
    ?assertEqual(locked, State),
    door_lock:stop().

button_test() ->
    door_lock:start_link([1, 2, 3, 4, 5]),
    Reply = door_lock:press_button(1),
    ?assertEqual(ok, Reply),
    {State, SoFar} = door_lock:get_state(),
    ?assertEqual(locked, State),
    ?assertEqual([1], SoFar),
    door_lock:stop().

unlock_test() ->
    door_lock:start_link([1, 2, 3, 4, 5]),
    unlock_door(),
    {State, _} = door_lock:get_state(),
    ?assertEqual(open, State),
    door_lock:stop().

wrong_code_test() ->
    door_lock:start_link([1, 2, 3, 4, 5]),
    door_lock:press_button(2),
    door_lock:press_button(3),
    door_lock:press_button(4),
    door_lock:press_button(5),
    door_lock:press_button(1),
    {State, SoFar} = door_lock:get_state(),
    ?assertEqual(locked, State),
    ?assertEqual([], SoFar),
    door_lock:stop().

lock_test() ->
    door_lock:start_link([1, 2, 3, 4, 5]),
    unlock_door(),
    {State, _} = door_lock:get_state(),
    ?assertEqual(open, State),
    door_lock:lock_door(),
    {NewState, _} = door_lock:get_state(),
    ?assertEqual(locked, NewState),
    door_lock:stop().

lock_when_locked_test() ->
    door_lock:start_link([1, 2, 3, 4, 5]),
    door_lock:lock_door(),
    {State, _} = door_lock:get_state(),
    ?assertEqual(locked, State),
    door_lock:stop().

button_when_open_test() ->
    door_lock:start_link([1, 2, 3, 4, 5]),
    unlock_door(),
    {State, _} = door_lock:get_state(),
    ?assertEqual(open, State),
    door_lock:stop().

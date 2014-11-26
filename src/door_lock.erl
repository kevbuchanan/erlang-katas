-module(door_lock).
-behaviour(gen_fsm).

% api
-export([start_link/1,
         stop/0,
         press_button/1,
         lock_door/0,
         get_state/0]).

% states
-export([locked/2, open/2]).

% callbacks
-export([init/1,
         handle_sync_event/4,
         handle_event/3,
         terminate/3,
         handle_info/3,
         code_change/4]).

start_link(Code) ->
    gen_fsm:start_link({local, door_lock}, door_lock, lists:reverse(Code), []).

init(Code) ->
    {ok, locked, {[], Code}}.

stop() ->
    gen_fsm:send_all_state_event(door_lock, stop).

press_button(Digit) ->
    gen_fsm:send_event(door_lock, {button, Digit}).

lock_door() ->
    gen_fsm:send_event(door_lock, lock_door).

locked({button, Digit}, {SoFar, Code}) ->
    case [Digit | SoFar] of
        Code ->
            {next_state, open, {[], Code}};
        Incomplete when length(Incomplete) < length(Code) ->
            {next_state, locked, {Incomplete, Code}};
        _ ->
            {next_state, locked, {[], Code}}
    end;

locked(_, StateData) ->
    {next_state, locked, StateData}.

open(lock_door, {_, Code}) ->
    {next_state, locked, {[], Code}};

open(_, StateData) ->
    {next_state, open, StateData}.

get_state() ->
    gen_fsm:sync_send_all_state_event(door_lock, get_state).

handle_sync_event(get_state, _, StateName, {SoFar, Code}) ->
    {reply, {StateName, SoFar}, StateName, {SoFar, Code}}.

handle_event(stop, _, StateData) ->
    {stop, normal, StateData}.

terminate(normal, _, _) ->
    ok.

handle_info(_, StateName, StateData) ->
    {next_state, StateName, StateData}.

code_change(_, StateName, StateData, _) ->
    {ok, StateName, StateData}.

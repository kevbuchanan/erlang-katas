-module(coin_change).
-export([change/1
        ]).

change(Amount) ->
    TakeAmount = fun(Coin, {Remaining, Coins}) ->
        Taken = Remaining div Coin,
        {Remaining - Taken * Coin, lists:append(Coins, [Taken])}
    end,
    {_, Change} = lists:foldl(TakeAmount, {Amount, []}, [100, 25, 10, 5, 1]),
    lists:reverse(Change).

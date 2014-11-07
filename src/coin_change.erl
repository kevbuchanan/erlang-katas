-module(coin_change).
-export([change/1
        ]).

take_amount(Amount, Coin) ->
    Taken = Amount div Coin,
    {Amount - Taken * Coin, Taken}.

change(Amount) ->
    {Five, Dollars} = take_amount(Amount, 100),
    {Four, Quarters} = take_amount(Five, 25),
    {Three, Dimes} = take_amount(Four, 10),
    {Two, Nickels} = take_amount(Three, 5),
    {_, Pennies} = take_amount(Two, 1),
    {Pennies, Nickels, Dimes, Quarters, Dollars}.

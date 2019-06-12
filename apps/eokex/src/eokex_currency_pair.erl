-module(eokex_currency_pair).

%% API
-export([
  decode/1, encode/1
]).

decode(Pair) ->
  [ A, B ] = binary:split(Pair, <<"-">>, [ global ]),
  { A, B}.

encode({A, B}) ->
  <<A/binary, "-", B/binary>>.

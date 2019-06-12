-module(eokex_orders_chain).

-behaviour(gen_server).

%% API
-export([
  start_link/1
]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).

-include_lib("eokex/include/order.hrl").

-record(state, {
  owner :: pid(),
  client :: pid(),
  chain :: [#order{}],
  balances = #{} :: maps:map(binary(), float())
}).

-define(COMISSION, 0.9984).

start_link([]) -> { error, no_chain };

start_link(Chain = [#order{}|_]) ->
  gen_server:start_link(?MODULE, [ self(), Chain ], []).

stop(Pid, Reason) ->
  gen_server:cast(Pid, { stop, Reason }).

init([ Owner, Chain ]) ->
  { ok, Client } = eokex_client:start_link(
    eokex_example_app:env(passphrase),
    eokex_example_app:env(public_key),
    eokex_example_app:env(secret_key)
  ),

  eokex_client:subscribe(Client, [
    %% Spot account
    <<"spot/account:BTC">>,
    <<"spot/account:USDT">>,
    <<"spot/account:LTC">>,
    <<"spot/account:NEO">>,
    %% Tracking spot orders
    <<"spot/order:LTC-BTC">>,
    <<"spot/order:LTC-ETH">>,
    <<"spot/order:ETH-BTC">>,
    <<"spot/order:NEO-BTC">>,
    <<"spot/order:NEO-ETH">>,
    <<"spot/order:ETH-BTC">>
  ]),

  State = #state{
    owner = Owner,
    chain = [ { Order, none } || Order <- Chain ],
    client = Client
  },

  lager:info("Spot balance: ~p", [ eokex_client:get_spot_balance(Client)]),
  { ok, send_order(State)}.

handle_call(_Request, _From, State) ->
  {reply, ok, State}.

handle_cast({stop, Reason}, State) ->
  lager:info("Stopped with reason: ~p", [ Reason ]),
  { stop, normal, State};

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info({eokex_client, Pid, { ws_response, Response }}, State) when State#state.client =:= Pid ->
  { Order, OrderState } = case State#state.chain of
    [] -> { undefined, undefined };
    [{ #order{} = O, St } | _ ] -> { O, St }
  end,
  NewState = case Response of
    #{ <<"table">> := Table, <<"data">> := Data } ->
      Processor = case Table of
        <<"spot/order">> -> fun process_spot_order/4;
        <<"spot/account">> -> fun process_spot_account/4
      end,
      lists:foldl(fun(Info, St) ->
        Processor(Info, Order, OrderState, St)
      end, State, Data);
    _ ->
      lager:error("Unknown response ~p", [ Response ]),
      State
  end,
  { noreply, NewState };

handle_info(Info, State) ->
  lager:info("Unknown info ~p ~n ~p", [ Info, State ]),
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

process_spot_order(#{ <<"client_oid">> := Id, <<"status">> := <<"open">>}, Order, sent, State) when Order#order.id =:= Id ->
  change_state_of_order(State, Order, open);

process_spot_order(#{ <<"client_oid">> := Id, <<"status">> := <<"filled">>, <<"filled_size">> := SecondCurrencyAmountBin, <<"filled_notional">> := FirstCurrencyAmountBin} = Data, Order, open, State) when Order#order.id =:= Id ->
  lager:info("Order data ~p", [ Data ]),
  { Currency1, Currency2 } = eokex_currency_pair:decode(Order#order.instrument_id),
  { Delta1, Delta2} = case Order#order.side of
    sell ->
      { -binary_to_float(SecondCurrencyAmountBin), binary_to_float(FirstCurrencyAmountBin) };
    buy ->
      { binary_to_float(SecondCurrencyAmountBin), -binary_to_float(FirstCurrencyAmountBin) }
  end,
  NewState0 = add_balance(State, Currency1, Delta1),
  NewState1 = add_balance(NewState0, Currency2, Delta2),
  change_state_of_order(NewState1, Order, filled);

process_spot_order(_, _, _, State) -> State.

process_spot_account(#{ <<"balance">> := Balance, <<"currency">> := Currency}, _, _, State) ->
  lager:info("Current balance ~p = ~p", [ Currency, Balance ]),
  State.

send_order(State) ->
  send_order(State, 1).

send_order(State = #state{ chain = [ { Order = #order{}, none } | _ ]}, Attempts) ->
  case eokex_client:send_spot_order(State#state.client, Order) of
    {ok, _ } -> change_state_of_order(State, Order, sent);
    { error, #{ <<"error_code">> := <<"33017">>}} when Attempts > 0 ->
      lager:info("Spot balance: ~p", [ eokex_client:get_spot_balance(State#state.client)]),
      timer:sleep(500),
      send_order(State, Attempts - 1)
  end;

send_order(State, _) -> State.

change_state_of_order(State, Order = #order{}, NewOrderState) ->
  change_state_of_order(State, Order#order.id, NewOrderState);

change_state_of_order(State, OrderId, NewOrderState = filled) ->
  lager:info("Change status of order ~p = ~p", [ OrderId, NewOrderState ]),
  case State#state.chain of
    [ { #order{ id = Id }, _ }, { Order, none } | Orders ] when OrderId =:= Id ->
      { NewOrder, NewState } = fill_order_size(Order, State),
      send_order(NewState#state{
        chain = [ {NewOrder, none } |  Orders ]
      });
    [ { #order{ id = Id }, _ } ] ->
      stop(self(), completed),
      State#state{
      chain = []
      };
    [] -> State
  end;

change_state_of_order(State, OrderId, NewOrderState) ->
  lager:info("Change status of order ~p = ~p", [ OrderId, NewOrderState ]),
  NewChain = case State#state.chain of
    [{ #order{ id = Id } = Order, _ } | Orders ] when OrderId =:= Id -> [ { Order, NewOrderState } | Orders ];
    _ -> error(internal_error)
  end,
  State#state{
    chain = NewChain
  }.

get_balance(State, Currency) ->
  maps:get(Currency, State#state.balances, 0).

add_balance(State, Currency, Amount) ->
  OldBalance = get_balance(State, Currency),
  NewBalance = maps:put(Currency, OldBalance + Amount * ?COMISSION, State#state.balances),
  lager:info("Balances ~p", [ NewBalance ]),
  State#state{
    balances = NewBalance
  }.

fill_order_size(#order{ side = buy } = Order, State) ->
  { _, Currency } = eokex_currency_pair:decode(Order#order.instrument_id),
  Amount = get_balance(State, Currency),
  true = Amount > 0,
  NewOrder = Order#order{
    size = Amount
  },
  NewState = add_balance(State, Currency, -Amount),
  { NewOrder, NewState };

fill_order_size(#order{ side = sell } = Order, State) ->
  { Currency, _ } = eokex_currency_pair:decode(Order#order.instrument_id),
  Amount = get_balance(State, Currency),
  true = Amount > 0,
  NewOrder = Order#order{
    size = Amount
  },
  NewState = add_balance(State, Currency, -Amount),
  { NewOrder, NewState }.

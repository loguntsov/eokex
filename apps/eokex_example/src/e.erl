-module(e).

%% API
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

-include_lib("eokex/include/order.hrl").

t0000() ->

  %% My test (empty)

  %PublicKey = <<"250dbf08-98c7-43ee-b9f7-0d2d80f7eb22">>,
  %SecretKey = <<"F14397B9B8E7C39BD4B677399954F804">>,
  %PassPhase = <<"1234567890">>,

  % Original

  PublicKey = <<"377e0be2-9d9a-4789-821d-b745e03b1f2b">>,
  SecretKey = <<"1A44F7B54E139DBC9734D72A33D01390">>,
  PassPhase = <<"Fnw7ty254hdg786">>,

  { ok, Pid } = eokex_client:start_link(PassPhase, PublicKey, SecretKey),
  true = is_process_alive(Pid),
  put(ws, Pid),
  Pid.

t() ->
  { ok, Chain1 } = eokex_orders_chain:start_link([
    #order{
      id = <<"order01">>,
      instrument_id = <<"LTC-BTC">>,
      type = market,
      size = <<"0.0001">>,
      side = buy
    },
    #order{
      id = <<"order02">>,
      instrument_id = <<"LTC-ETH">>,
      type = market,
      side = sell
    },
    #order{
      id = <<"order03">>,
      instrument_id = <<"ETH-BTC">>,
      type = market,
      side = sell
    }
  ]),
  { ok, Chain2 } = eokex_orders_chain:start_link([
    #order{
      id = <<"order11">>,
      instrument_id = <<"NEO-BTC">>,
      type = market,
      size = <<"0.017">>,
      side = buy
    },
    #order{
      id = <<"order12">>,
      instrument_id = <<"NEO-ETH">>,
      type = market,
      side = sell
    },
    #order{
      id = <<"order13">>,
      instrument_id = <<"ETH-BTC">>,
      type = market,
      side = sell
    }
  ]),
  ok.

balance() ->
  Pid = pid(),
  eokex_client:get_spot_balance(Pid).

pid() ->
  case get(ws) of
    undefined -> t0000();
    P when is_pid(P)-> P
  end.

-module(eokex_app).

-behaviour(application).

%% Application callbacks
-export([
  start/2,
  stop/1
]).

-export([
  env/1
]).

-define(APP, eokex).

start(_StartType, _StartArgs) ->
  #{
    host := WsHost,
    path := WsPath,
    port := WsPort,
    scheme := <<"wss">>
  } = uri_string:parse(env(wss_endpoint)),
  set_env(ws, { WsHost, WsPort, WsPath }),

  #{
    host := HttpHost,
    path := HttpPath,
    port := HttpPort,
    scheme := <<"https">>
  } = uri_string:parse(env(http_endpoint)),
  set_env(http, { HttpHost, HttpPort, HttpPath }),
  { ok, Pid } = eokex_sup:start_link(),
  { ok, Pid }.

stop(_State) ->
  ok.

env(Key) ->
  { ok, Value } = application:get_env(?APP, Key),
  Value.

set_env(Key, Value) ->
  ok = application:set_env(?APP, Key, Value).

%%%===================================================================
%%% Internal functions
%%%===================================================================

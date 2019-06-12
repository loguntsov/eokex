-module(eokex_example_app).

-behaviour(application).

%% Application callbacks
-export([
  start/2,
  stop/1
]).

-export([
  env/1
]).

-define(APP, eokex_example).

start(_StartType, _StartArgs) ->
  { ok, Pid } = eokex_example_app_sup:start_link(),
  spawn_link(fun() ->
    e:t()
  end),
  { ok, Pid }.
stop(_State) ->
  ok.

env(Key) ->
  { ok, Value } = application:get_env(?APP, Key),
  Value.

%%%===================================================================
%%% Internal functions
%%%===================================================================

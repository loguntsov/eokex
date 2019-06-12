-module(eokex_client).

-behaviour(gen_server).

%% API
-export([
  start_link/3,
  ws/2, ws/3,
  http/3, http/4,
  subscribe/2, unsubscribe/2,
  send_spot_order/2, get_spot_balance/1
]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3
]).

-define(SERVER, ?MODULE).
-define(PING, 20000).

-record(state, {
  owner :: pid(),
  api_key :: binary(),
  secret_key :: binary(),
  passphrase :: binary(),
  http :: pid(),
  ws :: pid(),
  ws_stream :: reference()
}).

start_link(Passphrase, PublicKey, SecretKey) ->
  { ok, Pid } = gen_server:start_link(?MODULE, [ self(), Passphrase, PublicKey, SecretKey], []),
  ok = gen_server:call(Pid, init),
  { ok, Pid }.

subscribe(Pid, Channels) ->
  ws(Pid, subscribe, Channels).

unsubscribe(Pid, Channels) ->
  ws(Pid, unsubscribe, Channels).

send_spot_order(Pid, Order) ->
  case http(Pid, post, <<"/api/spot/v3/orders">>, eokex_order:to_json(Order)) of
    { data, _, _, #{ <<"result">> := false} = Json} -> { error, Json };
    { data, _, _, #{ <<"result">> := true} = Json} -> { ok, Json }
  end.

get_spot_balance(Pid) ->
  { data, 200, _, Result } = eokex_client:http(Pid, get, <<"/api/spot/v3/accounts">>),
  Result.

ws(Pid, Op, Args) ->
  ws(Pid, #{
    op => Op,
    args => Args
  }).

ws(Pid, Json) ->
  gen_server:cast(Pid, { ws, Json}).

http(Pid, Method, URL) ->
  http(Pid, Method, URL, <<>>).

http(Pid, Method, URL, Json) when is_map(Json) ->
  http(Pid, Method, URL, jsx:encode(Json));

http(Pid, Method, URL, Bin) when is_binary(Bin) ->
  gen_server:call(Pid, { http, Method, URL, Bin}).

init([ Owner, Passphrase, PublicKey, SecretKey ]) ->
  {ok, #state{
    owner = Owner,
    api_key = PublicKey,
    secret_key = SecretKey,
    passphrase = Passphrase
  }}.

handle_call(init, _From, State) ->
  lager:info("OK0"),
  { HttpHost, HttpPort, _HttpPath } = eokex_app:env(http),
  { ok, HttpPid} = gun:open(binary_to_list(HttpHost), HttpPort, #{ transport => ssl }),
  lager:info("OK1"),
  { ok, _ } = gun:await_up(HttpPid, 5000),
  lager:info("OK2"),
  { WsHost, WsPort, WsPath } = eokex_app:env(ws),
  { ok, WsPid} = gun:open(binary_to_list(WsHost), WsPort, #{ transport => ssl }),
  lager:info("OK3"),
  { ok, _ } = gun:await_up(WsPid, 5000),
  lager:info("OK4"),

  StreamRef = gun:ws_upgrade(WsPid, WsPath),

  NewState = State#state{
    http = HttpPid,
    ws = WsPid,
    ws_stream = StreamRef
  },

  receive
    {gun_upgrade, ConnPid, Ref, [<<"websocket">>], _Headers} when ConnPid =:= WsPid, Ref =:= StreamRef ->
      NewState1 = ws_login(NewState),
      { reply, ok, tick(NewState1)};
    {gun_response, ConnPid, ConnPid, Ref, Status, Headers} when ConnPid =:= WsPid, Ref =:= StreamRef ->
      exit({ws_upgrade_failed, Status, Headers});
    {gun_error, ConnPid, Ref, Reason} when ConnPid =:= WsPid, Ref =:= StreamRef ->
      exit({ws_upgrade_failed, Reason});
    Any -> exit(Any)
  %% More clauses here as needed.
  after 5000 ->
    exit(timeout)
  end;

handle_call({ http, Method, Url, Body}, _From, State) ->
  Ret = http_request(State, Method, Url, Body, 4500),
  { reply, Ret, State };

handle_call(_Request, _From, State) ->
  {reply, error, State}.

handle_cast({ws, Json}, State) ->
  Bin = jsx:encode(Json),
  lager:info("WS Request ~s", [ Bin ]),
  ok = gun:ws_send(State#state.ws, {text,Bin}),
  { noreply, State};

handle_cast(_Request, State) ->
  lager:info("Uknown cast: ~p", [ _Request ]),
  {noreply, State}.

handle_info(ping, State) ->
  ok = gun:ws_send(State#state.ws, { text, <<"ping">>}),
  { noreply, tick(State)};

handle_info({gun_ws, Pid, Ref, { binary, <<43,200,207,75,7,0>> }}, State) when Pid =:= State#state.ws, Ref =:= State#state.ws_stream ->
  { noreply, State};

handle_info({gun_ws, Pid, Ref, { binary, Frame }}, State) when Pid =:= State#state.ws, Ref =:= State#state.ws_stream ->
  Decoded = zlib:unzip(Frame),
  Json = try
    jsx:decode(Decoded, [ return_maps ])
  catch
    error:badarg -> bad_json
  end,
  NewState = case Json of
    _ when is_map(Json) ->
      %% lager:info("WS Response: ~p", [ Json ]),
      #state{} = process_ws_response(Json, State);
    bad_json ->
      lager:info("WS Bad json response: ~p", [ Frame ]),
      State
  end,
  { noreply, NewState};
handle_info({gun_up, _Pid, http}, State) ->
  { noreply, State };

handle_info({gun_down, _Pid, http, _, _, _}, State) ->
  { noreply, State};

handle_info({gun_down, _Pid, ws, _, _, _}, State) ->
  %% TODO: We should keep all subscriptions and reconnect with subscription intialisation
  { stop, ws_disconnect, State};

handle_info(_Info, State) ->
  lager:info("Uknown info: ~p ~p", [ _Info, State ]),
  {noreply, State}.

terminate(_Reason, State) ->
  gun:close(State#state.http),
  gun:close(State#state.ws),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

tick(State) ->
  erlang:send_after(?PING, self(), ping),
  State.

http_request(State, Method, Url, Body, _Timeout) ->
  #state{
    http = HttpPid
  } = State,
  %Body = <<>>,
  %Url = <<>>>
  %Method = <<"GET">>,
  MethodStr = case Method of
    get -> <<"GET">>;
    post -> <<"POST">>;
    delete -> <<"DELETE">>
  end,
  Timestamp = iso8601:format(os:timestamp()),
  Sign = base64:encode(crypto:hmac(sha256, State#state.secret_key, <<Timestamp/binary, MethodStr/binary, Url/binary, Body/binary>>)),
  Headers = [
    { <<"OK-ACCESS-KEY">>, State#state.api_key },
    { <<"OK-ACCESS-TIMESTAMP">>, Timestamp },
    { <<"OK-ACCESS-SIGN">>, Sign },
    { <<"OK-ACCESS-PASSPHRASE">>, State#state.passphrase},
    { <<"content-type">>, <<"application/json">>}
  ],
  lager:info("HTTP request: ~s:~s:~s", [ MethodStr, Url, Body ]),
  StreamRef = gun:request(State#state.http, MethodStr, Url, Headers, Body),
  case gun:await(HttpPid, StreamRef, 10000) of
    {response, fin, Status, H} ->
      { no_data, Status, H };
    {response, nofin, Status, H} ->
      {ok, B } = gun:await_body(HttpPid, StreamRef),
      { data, Status, H, jsx:decode(B, [ return_maps ]) }
  end.

ws_send(State, Json, Fun) ->
  Bin = jsx:encode(Json),
  lager:info("WS Request ~s", [ Bin ]),
  ok = gun:ws_send(State#state.ws, {text,Bin }),
  receive
    {gun_ws, Pid, Ref, { binary, Frame }} when Pid =:= State#state.ws, Ref =:= State#state.ws_stream ->
      Json0 = jsx:decode(zlib:unzip(Frame), [ return_maps ]),
      %% lager:info("WS Response ~p", [ Json0 ]),
      Fun(Json0, State);
    Any -> exit(Any)
  end.

ws_login(State) ->
  Timestamp = integer_to_binary(erlang:system_time(second)),
  Sign = base64:encode(crypto:hmac(sha256, State#state.secret_key, <<Timestamp/binary, "GET/users/self/verify">>)),
  ws_send(State, #{
    op => login,
    args => [ State#state.api_key,State#state.passphrase,Timestamp, Sign]
  }, fun
      (#{ <<"event">> := <<"login">>, <<"success">> := true }, State) ->
        lager:info("WS Login is success"),
        State;
      (Any, _State) -> exit({cant_login_ws, Any})
  end).

process_ws_response(#{ <<"event">> := <<"subscribe">>, <<"channel">> := _ }, State) ->
  State;

process_ws_response(#{ <<"event">> := <<"unsubscribe">>, <<"channel">> := _ }, State) ->
  State;

process_ws_response(Json, State) ->
  (State#state.owner) ! { eokex_client, self(), { ws_response, Json} },
  State.


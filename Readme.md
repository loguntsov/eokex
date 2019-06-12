# Example of working with OKEx exchange.

It makes 2 chains with trying buy and sell cryptocurrencies by circle at same time.

# Launch

make run

# Requirements

* Erlang 21 or above
* Make
* rebar3

# Example of log:

```
2019-06-13 02:21:17.412 [info] <0.43.0> Application lager started on node nonode@nohost
2019-06-13 02:21:17.414 [info] <0.43.0> Application cowlib started on node nonode@nohost
2019-06-13 02:21:17.414 [info] <0.43.0> Application gun started on node nonode@nohost
2019-06-13 02:21:17.414 [info] <0.43.0> Application jsx started on node nonode@nohost
2019-06-13 02:21:17.423 [info] <0.43.0> Application eokex started on node nonode@nohost
2019-06-13 02:21:17.425 [info] <0.43.0> Application eokex_example started on node nonode@nohost
2019-06-13 02:21:17.430 [info] <0.315.0>@eokex_client:handle_call:84 OK0
2019-06-13 02:21:17.435 [info] <0.315.0>@eokex_client:handle_call:87 OK1
2019-06-13 02:21:17.655 [info] <0.315.0>@eokex_client:handle_call:89 OK2
2019-06-13 02:21:17.656 [info] <0.315.0>@eokex_client:handle_call:92 OK3
2019-06-13 02:21:18.654 [info] <0.315.0>@eokex_client:handle_call:94 OK4
2019-06-13 02:21:19.004 [info] <0.315.0>@eokex_client:ws_send:221 WS Request {"args":["377e0be2-9d9a-4789-821d-b745e03b1f2b","Fnw7ty254hdg786","1560381678","8j0WaA/EOAmOGsDpyY8kIsN6EP+3fZVBGbgvfz1GbXY="],"op":"login"}
2019-06-13 02:21:19.348 [info] <0.315.0>@eokex_client:ws_login:239 WS Login is success
2019-06-13 02:21:19.348 [info] <0.315.0>@eokex_client:handle_cast:127 WS Request {"args":["spot/account:BTC","spot/account:USDT","spot/account:LTC","spot/account:NEO","spot/order:LTC-BTC","spot/order:LTC-ETH","spot/order:ETH-BTC","spot/order:NEO-BTC","spot/order:NEO-ETH","spot/order:ETH-BTC"],"op":"subscribe"}
2019-06-13 02:21:19.349 [info] <0.315.0>@eokex_client:http_request:209 HTTP request: GET:/api/spot/v3/accounts:
2019-06-13 02:21:19.591 [info] <0.314.0>@eokex_orders_chain:init:67 Spot balance: [#{<<"available">> => <<"0.01758708">>,<<"balance">> => <<"0.01758708">>,<<"currency">> => <<"BTC">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.06436648">>,<<"balance">> => <<"0.06436648">>,<<"currency">> => <<"LTC">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.01482376">>,<<"balance">> => <<"0.01482376">>,<<"currency">> => <<"ETH">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.05278861">>,<<"balance">> => <<"0.05278861">>,<<"currency">> => <<"USDT">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.0112534">>,<<"balance">> => <<"0.0112534">>,<<"currency">> => <<"NEO">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>}]
2019-06-13 02:21:19.592 [info] <0.315.0>@eokex_client:http_request:209 HTTP request: POST:/api/spot/v3/orders:{"client_oid":"order01","instrument_id":"LTC-BTC","margin_trading":1,"notional":"0.0001","order_type":0,"side":"buy","type":"market"}
2019-06-13 02:21:19.868 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order01">> = sent
2019-06-13 02:21:19.868 [info] <0.327.0>@eokex_client:handle_call:84 OK0
2019-06-13 02:21:19.868 [info] <0.327.0>@eokex_client:handle_call:87 OK1
2019-06-13 02:21:19.923 [info] <0.327.0>@eokex_client:handle_call:89 OK2
2019-06-13 02:21:19.923 [info] <0.327.0>@eokex_client:handle_call:92 OK3
2019-06-13 02:21:20.108 [info] <0.314.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"BTC">> = <<"0.017587084736025">>
2019-06-13 02:21:20.122 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order01">> = open
2019-06-13 02:21:20.258 [info] <0.314.0>@eokex_orders_chain:process_spot_order:118 Order data #{<<"client_oid">> => <<"order01">>,<<"filled_notional">> => <<"0.000099998018">>,<<"filled_size">> => <<"0.006073">>,<<"instrument_id">> => <<"LTC-BTC">>,<<"last_fill_px">> => <<"0.016466">>,<<"last_fill_qty">> => <<"0.006073">>,<<"last_fill_time">> => <<"2019-06-12T23:21:20.033Z">>,<<"margin_trading">> => <<"1">>,<<"notional">> => <<"0.0001">>,<<"order_id">> => <<"2991435266073600">>,<<"order_type">> => <<"0">>,<<"price">> => <<>>,<<"side">> => <<"buy">>,<<"size">> => <<"0">>,<<"state">> => <<"2">>,<<"status">> => <<"filled">>,<<"timestamp">> => <<"2019-06-12T23:21:20.000Z">>,<<"type">> => <<"market">>}
2019-06-13 02:21:20.259 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"LTC">> => 0.0060632832}
2019-06-13 02:21:20.259 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -9.98380211712e-5,<<"LTC">> => 0.0060632832}
2019-06-13 02:21:20.259 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:154 Change status of order <<"order01">> = filled
2019-06-13 02:21:20.259 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -9.98380211712e-5,<<"LTC">> => 9.701253120000634e-6}
2019-06-13 02:21:20.260 [info] <0.315.0>@eokex_client:http_request:209 HTTP request: POST:/api/spot/v3/orders:{"client_oid":"order02","instrument_id":"LTC-ETH","margin_trading":1,"order_type":0,"side":"sell","size":0.0060632832,"type":"market"}
2019-06-13 02:21:20.514 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order02">> = sent
2019-06-13 02:21:20.515 [info] <0.314.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"BTC">> = <<"0.017487086718025">>
2019-06-13 02:21:20.515 [info] <0.314.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"LTC">> = <<"0.070430374">>
2019-06-13 02:21:20.616 [info] <0.314.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"LTC">> = <<"0.070430374">>
2019-06-13 02:21:20.904 [info] <0.327.0>@eokex_client:handle_call:94 OK4
2019-06-13 02:21:21.126 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order02">> = open
2019-06-13 02:21:21.134 [info] <0.314.0>@eokex_orders_chain:process_spot_order:118 Order data #{<<"client_oid">> => <<"order02">>,<<"filled_notional">> => <<"0.0031570041">>,<<"filled_size">> => <<"0.006063">>,<<"instrument_id">> => <<"LTC-ETH">>,<<"last_fill_px">> => <<"0.5207">>,<<"last_fill_qty">> => <<"0.006063">>,<<"last_fill_time">> => <<"2019-06-12T23:21:20.839Z">>,<<"margin_trading">> => <<"1">>,<<"notional">> => <<>>,<<"order_id">> => <<"2991435309720576">>,<<"order_type">> => <<"0">>,<<"price">> => <<>>,<<"side">> => <<"sell">>,<<"size">> => <<"0.006063">>,<<"state">> => <<"2">>,<<"status">> => <<"filled">>,<<"timestamp">> => <<"2019-06-12T23:21:20.000Z">>,<<"type">> => <<"market">>}
2019-06-13 02:21:21.134 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -9.98380211712e-5,<<"LTC">> => -0.006043597946879999}
2019-06-13 02:21:21.134 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -9.98380211712e-5,<<"ETH">> => 0.00315195289344,<<"LTC">> => -0.006043597946879999}
2019-06-13 02:21:21.134 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:154 Change status of order <<"order02">> = filled
2019-06-13 02:21:21.134 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -9.98380211712e-5,<<"ETH">> => 5.0431246295043475e-6,<<"LTC">> => -0.006043597946879999}
2019-06-13 02:21:21.134 [info] <0.315.0>@eokex_client:http_request:209 HTTP request: POST:/api/spot/v3/orders:{"client_oid":"order03","instrument_id":"ETH-BTC","margin_trading":1,"order_type":0,"side":"sell","size":0.00315195289344,"type":"market"}
2019-06-13 02:21:21.232 [info] <0.327.0>@eokex_client:ws_send:221 WS Request {"args":["377e0be2-9d9a-4789-821d-b745e03b1f2b","Fnw7ty254hdg786","1560381681","zi9tIch4HodY5Yx9rXGINKbBZFSpFM555BsuACHZuPc="],"op":"login"}
2019-06-13 02:21:21.396 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order03">> = sent
2019-06-13 02:21:21.396 [info] <0.314.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"LTC">> = <<"0.064367374">>
2019-06-13 02:21:21.563 [info] <0.327.0>@eokex_client:ws_login:239 WS Login is success
2019-06-13 02:21:21.563 [info] <0.327.0>@eokex_client:handle_cast:127 WS Request {"args":["spot/account:BTC","spot/account:USDT","spot/account:LTC","spot/account:NEO","spot/order:LTC-BTC","spot/order:LTC-ETH","spot/order:ETH-BTC","spot/order:NEO-BTC","spot/order:NEO-ETH","spot/order:ETH-BTC"],"op":"subscribe"}
2019-06-13 02:21:21.563 [info] <0.327.0>@eokex_client:http_request:209 HTTP request: GET:/api/spot/v3/accounts:
2019-06-13 02:21:21.760 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order03">> = open
2019-06-13 02:21:21.773 [info] <0.314.0>@eokex_orders_chain:process_spot_order:118 Order data #{<<"client_oid">> => <<"order03">>,<<"filled_notional">> => <<"0.00009947707">>,<<"filled_size">> => <<"0.003151">>,<<"instrument_id">> => <<"ETH-BTC">>,<<"last_fill_px">> => <<"0.03157">>,<<"last_fill_qty">> => <<"0.003151">>,<<"last_fill_time">> => <<"2019-06-12T23:21:21.550Z">>,<<"margin_trading">> => <<"1">>,<<"notional">> => <<>>,<<"order_id">> => <<"2991435367255040">>,<<"order_type">> => <<"0">>,<<"price">> => <<>>,<<"side">> => <<"sell">>,<<"size">> => <<"0.003151">>,<<"state">> => <<"2">>,<<"status">> => <<"filled">>,<<"timestamp">> => <<"2019-06-12T23:21:21.000Z">>,<<"type">> => <<"market">>}
2019-06-13 02:21:21.773 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -9.98380211712e-5,<<"ETH">> => -0.0031409152753704957,<<"LTC">> => -0.006043597946879999}
2019-06-13 02:21:21.773 [info] <0.314.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -5.201144831999942e-7,<<"ETH">> => -0.0031409152753704957,<<"LTC">> => -0.006043597946879999}
2019-06-13 02:21:21.773 [info] <0.314.0>@eokex_orders_chain:change_state_of_order:154 Change status of order <<"order03">> = filled
2019-06-13 02:21:21.773 [info] <0.314.0>@eokex_orders_chain:handle_cast:74 Stopped with reason: completed
2019-06-13 02:21:21.800 [info] <0.326.0>@eokex_orders_chain:init:67 Spot balance: [#{<<"available">> => <<"0.01758641">>,<<"balance">> => <<"0.01758641">>,<<"currency">> => <<"BTC">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.06436737">>,<<"balance">> => <<"0.06436737">>,<<"currency">> => <<"LTC">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.01482503">>,<<"balance">> => <<"0.01482503">>,<<"currency">> => <<"ETH">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.05278861">>,<<"balance">> => <<"0.05278861">>,<<"currency">> => <<"USDT">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>},#{<<"available">> => <<"0.0112534">>,<<"balance">> => <<"0.0112534">>,<<"currency">> => <<"NEO">>,<<"frozen">> => <<"0">>,<<"hold">> => <<"0">>,<<"holds">> => <<"0">>,<<"id">> => <<"9783086">>}]
2019-06-13 02:21:21.801 [info] <0.327.0>@eokex_client:http_request:209 HTTP request: POST:/api/spot/v3/orders:{"client_oid":"order11","instrument_id":"NEO-BTC","margin_trading":1,"notional":"0.017","order_type":0,"side":"buy","type":"market"}
2019-06-13 02:21:22.061 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order11">> = sent
2019-06-13 02:21:22.213 [info] <0.326.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"BTC">> = <<"0.01758641457242">>
2019-06-13 02:21:22.253 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order11">> = open
2019-06-13 02:21:22.289 [info] <0.326.0>@eokex_orders_chain:process_spot_order:118 Order data #{<<"client_oid">> => <<"order11">>,<<"filled_notional">> => <<"0.01699999822">>,<<"filled_size">> => <<"10.7775">>,<<"instrument_id">> => <<"NEO-BTC">>,<<"last_fill_px">> => <<"0.001578">>,<<"last_fill_qty">> => <<"3.88072">>,<<"last_fill_time">> => <<"2019-06-12T23:21:22.122Z">>,<<"margin_trading">> => <<"1">>,<<"notional">> => <<"0.017">>,<<"order_id">> => <<"2991435410974720">>,<<"order_type">> => <<"0">>,<<"price">> => <<>>,<<"side">> => <<"buy">>,<<"size">> => <<"0">>,<<"state">> => <<"2">>,<<"status">> => <<"filled">>,<<"timestamp">> => <<"2019-06-12T23:21:22.000Z">>,<<"type">> => <<"market">>}
2019-06-13 02:21:22.289 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"NEO">> => 10.760256}
2019-06-13 02:21:22.289 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -0.016972798222847998,<<"NEO">> => 10.760256}
2019-06-13 02:21:22.289 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:154 Change status of order <<"order11">> = filled
2019-06-13 02:21:22.289 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -0.016972798222847998,<<"NEO">> => 0.01721640960000137}
2019-06-13 02:21:22.289 [info] <0.327.0>@eokex_client:http_request:209 HTTP request: POST:/api/spot/v3/orders:{"client_oid":"order12","instrument_id":"NEO-ETH","margin_trading":1,"order_type":0,"side":"sell","size":10.760256,"type":"market"}
2019-06-13 02:21:22.552 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order12">> = sent
2019-06-13 02:21:22.552 [info] <0.326.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"BTC">> = <<"0.00058641635242">>
2019-06-13 02:21:22.552 [info] <0.326.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"NEO">> = <<"10.772587155">>
2019-06-13 02:21:22.613 [info] <0.326.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"NEO">> = <<"10.772587155">>
2019-06-13 02:21:22.813 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order12">> = open
2019-06-13 02:21:22.856 [info] <0.326.0>@eokex_orders_chain:process_spot_order:118 Order data #{<<"client_oid">> => <<"order12">>,<<"filled_notional">> => <<"0.534784425">>,<<"filled_size">> => <<"10.76025">>,<<"instrument_id">> => <<"NEO-ETH">>,<<"last_fill_px">> => <<"0.0497">>,<<"last_fill_qty">> => <<"0.90395">>,<<"last_fill_time">> => <<"2019-06-12T23:21:22.636Z">>,<<"margin_trading">> => <<"1">>,<<"notional">> => <<>>,<<"order_id">> => <<"2991435442758656">>,<<"order_type">> => <<"0">>,<<"price">> => <<>>,<<"side">> => <<"sell">>,<<"size">> => <<"10.76025">>,<<"state">> => <<"2">>,<<"status">> => <<"filled">>,<<"timestamp">> => <<"2019-06-12T23:21:22.000Z">>,<<"type">> => <<"market">>}
2019-06-13 02:21:22.856 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -0.016972798222847998,<<"NEO">> => -10.725817190399997}
2019-06-13 02:21:22.856 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -0.016972798222847998,<<"ETH">> => 0.5339287699199999,<<"NEO">> => -10.725817190399997}
2019-06-13 02:21:22.856 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:154 Change status of order <<"order12">> = filled
2019-06-13 02:21:22.856 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -0.016972798222847998,<<"ETH">> => 8.542860318719869e-4,<<"NEO">> => -10.725817190399997}
2019-06-13 02:21:22.856 [info] <0.327.0>@eokex_client:http_request:209 HTTP request: POST:/api/spot/v3/orders:{"client_oid":"order13","instrument_id":"ETH-BTC","margin_trading":1,"order_type":0,"side":"sell","size":0.5339287699199999,"type":"market"}
2019-06-13 02:21:23.642 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order13">> = sent
2019-06-13 02:21:23.642 [info] <0.326.0>@eokex_orders_chain:process_spot_account:133 Current balance <<"NEO">> = <<"0.012337155">>
2019-06-13 02:21:23.848 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:170 Change status of order <<"order13">> = open
2019-06-13 02:21:23.983 [info] <0.326.0>@eokex_orders_chain:process_spot_order:118 Order data #{<<"client_oid">> => <<"order13">>,<<"filled_notional">> => <<"0.01685610696">>,<<"filled_size">> => <<"0.533928">>,<<"instrument_id">> => <<"ETH-BTC">>,<<"last_fill_px">> => <<"0.03157">>,<<"last_fill_qty">> => <<"0.533928">>,<<"last_fill_time">> => <<"2019-06-12T23:21:23.817Z">>,<<"margin_trading">> => <<"1">>,<<"notional">> => <<>>,<<"order_id">> => <<"2991435514648576">>,<<"order_type">> => <<"0">>,<<"price">> => <<>>,<<"side">> => <<"sell">>,<<"size">> => <<"0.533928">>,<<"state">> => <<"2">>,<<"status">> => <<"filled">>,<<"timestamp">> => <<"2019-06-12T23:21:24.000Z">>,<<"type">> => <<"market">>}
2019-06-13 02:21:23.983 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -0.016972798222847998,<<"ETH">> => -0.5322194291681279,<<"NEO">> => -10.725817190399997}
2019-06-13 02:21:23.983 [info] <0.326.0>@eokex_orders_chain:add_balance:185 Balances #{<<"BTC">> => -1.4366103398399943e-4,<<"ETH">> => -0.5322194291681279,<<"NEO">> => -10.725817190399997}
2019-06-13 02:21:23.983 [info] <0.326.0>@eokex_orders_chain:change_state_of_order:154 Change status of order <<"order13">> = filled
2019-06-13 02:21:23.983 [info] <0.326.0>@eokex_orders_chain:handle_cast:74 Stopped with reason: completed


```
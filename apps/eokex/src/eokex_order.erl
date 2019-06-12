-module(eokex_order).

%% API
-export([
  to_json/1
]).

-include("order.hrl").

to_json(Order = #order{ type = market, side = buy }) ->
  (to_json_default(Order))#{
    notional => Order#order.size,
    order_type => 0
  };

to_json(Order = #order{ type = market, side = sell }) ->
  (to_json_default(Order))#{
    size => Order#order.size,
    order_type => 0
  };

to_json(Order = #order{ type = limit }) ->
  (to_json_default(Order))#{
    price => Order#order.price,
    size => Order#order.size
  }.

to_json_default(Order) ->
  #{
    client_oid => Order#order.id,
    instrument_id => Order#order.instrument_id,
    margin_trading => 1,
    type => Order#order.type,
    side => Order#order.side
  }.


-record(order, {
  id :: binary(),
  instrument_id :: binary(),
  type :: limit | market,
  side :: buy | sell,
  size :: float(),
  price :: float() | undefined
}).

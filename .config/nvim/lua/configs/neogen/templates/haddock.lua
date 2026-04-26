local i = require("neogen.types.template").item

return {
  { nil, "-- | $1", { no_results = true, type = { "func" } } },
  { nil, "-- | $1" },
  { nil, "--" },
  { i.Parameter, "-- @param %s $1", { type = { "func" } } },
  { i.Return, "-- @return $1", { type = { "func" } } },
}

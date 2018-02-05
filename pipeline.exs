# pipeline.exs
# example of using pipe, on the road to streams

import Enum
[1,2,3,4,5]
|> map(&(&1 * &1))
|> with_index
|> map(fn {value, index} -> value - index end)
|> IO.inspect
# sum2.exs
# using a private inner function to recursively sum,
# including keeping track of the sum
# without an additional parameters on the outer function


defmodule MyList do
    
    def sum(list), do: _sum(list, 0)

    # private methods
    def _sum([], total), do: total
    def _sum([head | tail ], total), do: _sum(tail, head + total)
end
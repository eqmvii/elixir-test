# factorial1.exs
# using pattern matching to do factorial work in elixir

# NOTE: This works, but it would be improved through the use of tail recursion

defmodule Factorial do
    def of(0), do: 1
    def of(n), do: n * of(n - 1)
end
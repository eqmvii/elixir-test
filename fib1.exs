# fib1.exs
# fibonaci sequence in Elixir

# (almost written blind too w00t)

defmodule Fib do
    def of(1), do: 1
    def of(2), do: 1
    def of(n), do: of(n - 1) + of(n-2)
end
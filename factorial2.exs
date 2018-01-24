# factorial2.exs
# factorial, only with fewer infinite loops

defmodule Factorial do
    def of(0), do: 1
    def of(n) when n > 0 do
        n * of(n - 1)
    end
end
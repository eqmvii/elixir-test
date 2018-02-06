# fizzbuzzmatch.exs 
# fizzbuzz using map and matching and piping
# instead of the cond macro

defmodule FizzBuzz do
    # create a range of numbers from 1 to n
    # then call the fizzbuzz function on each number
    # calculate the modulo for each number against 3 and 4
    # then pattern match to pick the appropriate fizzbuzz word in that range
    def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

    defp fizzbuzz(n), do: _fizzword(n, rem(n, 3), rem(n,5))

    defp _fizzword(_n, 0, 0), do: "FizzBuzz"
    defp _fizzword(_n, 0, _), do: "Fizz"
    defp _fizzword(_n, _, 0), do: "Buzz"
    defp _fizzword(n, _, _), do: n
end
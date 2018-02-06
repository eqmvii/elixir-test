# fizzbuzz.exs
# doing fizzbuzz, in elixir, with the cond macro

defmodule FizzBuzz do
    
    def upto(n) when n > 0, do: _upto(1, n, [])

    def _upto(_current, 0, result), do: Enum.reverse result

    def _upto(current, remaining, result) do
        next_answer = 
            cond do
                rem(current, 3) == 0 and rem(current, 5) == 0 ->
                    "FizzBuzz"
                rem(current, 3) == 0 ->
                    "Fizz"
                rem(current, 5) == 0 ->
                    "Buzz"
                # a default case
                true ->
                    current
            end
            _upto(current+1, remaining-1, [next_answer | result ])
    end
end
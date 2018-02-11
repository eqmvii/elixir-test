# fizzbuzz.exs
# doing fizzbuzz, in elixir, with the cond macro

defmodule FizzBuzz do
    
    # sub function call to mask the awkward arity (i.e. must have three arguments
    # to make the recursion work, but somebody using the function would expect to
    # only need to send one argument, the number of fizzbuzz numbrers to print
    def upto(n) when n > 0, do: _upto(1, n, [])

    # base recursive case - return the list in reverse order
    def _upto(_current, 0, result), do: Enum.reverse result

    # recursive case 
    def _upto(current, remaining, result) do
        next_answer = 
            cond do
                rem(current, 3) == 0 and rem(current, 5) == 0 ->
                    "FizzBuzz"
                rem(current, 3) == 0 ->
                    "Fizz"
                rem(current, 5) == 0 ->
                    "Buzz"
                # a default case for the cond statement
                # that will execute if none of the prior 
                # statements evaluate to true
                true ->
                    current
            end
            # recursive call to _upto, increasing current by 1, reducing remaining by 1,
            # and sending a new list with next_answer as the head of the list and 
            # result, all of the old numbers, as the tail of the list
            _upto(current+1, remaining-1, [next_answer | result ])
    end
end
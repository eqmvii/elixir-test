# times.exs
# usage: try $ iex times.exs to load + run from the command line
# if already in iex, instead use the c helper: c "times.exs"

# example of a module, often refered to as double/1 
# because the number of arguments partially determines the way we identify elixir functions (read: its arity)

defmodule Times do
    def double(n) do
        n * 2
    end
end

# End isn't strictly necessary, it's syntactic sugar. At compile it becomes do: on its own, and often single line usage omits the end.
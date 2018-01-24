# guard.exs
# example of a module with guard clauses

defmodule Guard do
    def what_is(x) when is_number(x) do
        IO.puts "#{x} is a number!"
    end
    def what_is(x) when is_list(x) do
        IO.puts "#{x} is a List!"
    end
    def what_is(x) when is_atom(x) do
        IO.puts "#{x} is an atom!"
    end
end
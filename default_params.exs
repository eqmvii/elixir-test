# default_params.exs

defmodule Example do
    # Function expects 4 arguments and has two mid-way default parameters
    def func(p1, p2 \\ 2, p3 \\ 3, p4) do
        IO.inspect [p1, p2, p3, p4]
    end
end

# NB: Can get surprising when elixir gets to pattern matching
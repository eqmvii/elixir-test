# mylist1.exs page 69

defmodule MyList do
    def add_1([]), do: []
    def add_1([head | tail]), do: [ head+1 | add_1(tail)]

    def square([]), do: []
    def square([head | tail]), do: [head * head | square(tail)]

    def len([]), do: 0
    def len([_head | tail] ), do: 1 + len(tail)

    def map([], _func), do: []
    def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]
    # usage examples: 
    # MyList.map [1,3,9], fn (n) -> n*n end
    # MyList.map [1,3,9], &(&1 > 2)
end
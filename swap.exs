# swap.exs
# swaps values in a list

# import will bring it into the name space
#
# iex
# c "swap.exs"
# import Swapper

defmodule Swapper do
    def swap([]), do: []
    def swap([ a, b | tail ]), do: [b, a | swap(tail) ]
    def swap([_]), do: raise "Can't swap on lists with odd number of items!"
end
# defstruct.exs 
# demo of elixir structs

defmodule Subscriber do
    defstruct name: "", paid: false, over_18: true
end

# examples
'''
iex(1)> c "defstruct.exs" 
[Subscriber]
iex(2)> s1 = %Subscriber{}
%Subscriber{name: "", over_18: true, paid: false}
iex(3)> s2 = %Subscriber{name: "Dave"}
%Subscriber{name: "Dave", over_18: true, paid: false}
'''
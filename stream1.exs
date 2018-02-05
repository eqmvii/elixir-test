#stream1.exs
# you liked pipelines just wait until you see streams

[1,2,3,4]
|> Stream.map(&(&1*&1)) # [1,4,9,16]
|> Stream.map(&(&1+1)) # [2, 5, 10, 17]
|> Stream.filter(fn x -> rem(x,2) == 1 end) # [5, 17]
|> Enum.to_list # now it's a list
|> IO.inspect # now it's printed
# hello.exs
# Hello World in elixir
# by Eric Mancini
# Execution:
# $ elixir hello.exs

IO.puts "Hello world" <> " from Elixir!"

# testing some math, binding, and immutability

a = 1

IO.puts a

a = a + 1

IO.puts a

name = "eric"

cap_name = String.capitalize name

IO.puts name
IO.puts cap_name

# using atoms and string interpolation

IO.puts "Hello #{:world}, this time with atoms and interpolation"

# recursive loop example from docs
defmodule Recursion do
  def print_multiple_times(msg, n) when n <= 1 do
    IO.puts msg
  end

  def print_multiple_times(msg, n) do
    IO.puts msg
    print_multiple_times(msg, n - 1)
  end
end

Recursion.print_multiple_times("Hello!", 3)
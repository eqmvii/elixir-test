# hello.exs
# Hello World in elixir, and also testing Elixir functionality from the Dave Thomas book
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

# Maps, printing maps, using an atom. Dot notation only works when keys are atoms.

person = %{ :first_name => "Eric", "last_name" => "Mancini"}

IO.puts person.first_name <> " " <> person["last_name"]

# Functions!

sum = fn (x, y) -> x + y end

IO.puts sum.(3,4)

greet = fn () -> IO.puts "Hello! Greet function called." end

greet.()

# Swap as a function

swap = fn {a, b} -> {b, a} end

IO.puts "Swapping 6,8 . . ."
swapvar = swap.({6,8})
# IO.puts elem(swapvar, 0) <> ", " <> elem(swapvar, 1)
IO.puts elem(swapvar, 1)
IO

# TODO: Look at this
# https://elixirforum.com/t/convert-a-string-to-an-integer/4784/4

# File opening example:
# File.open returns a tuple with :ok as the first argument if the file was opened succesfully
# Look for two signatures can cause the function to run differently depending on the arguments it was passed
# the :file.format_error calls an underlying erlang file module
# the File.open calls an Elixir module
# String interpolation: contents of #{} are executed and then substituted back in
handle_open = fn 
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
  end

  IO.puts "Opening this file: "
  IO.puts handle_open.(File.open("hello.exs"))

  IO.puts "Opening a non-existant file: "
  IO.puts handle_open.(File.open("DoesNotExist.false"))

  IO.puts("# # # # # # # # # # # #")

  # functions can return functions

  funfun = fn -> fn -> "hello, returned function called" end end

  funteststring = funfun.().()
  IO.puts funteststring

  # function scope / closure is like JavaScript - scope encloses the bindings of its variables, keeping them available for later.

  greeter = fn name -> (fn -> "Hello #{name}" end) end
  david_greeter = greeter.("David")
  greeterstring = david_greeter.()
  IO.puts greeterstring

  prefix = fn pref -> (fn name -> "Hello #{pref} #{name}" end) end
  prefname = prefix.("Mr.").("Mancini")
  IO.puts prefname

  # pins (^) can be used to make sure variables are used at current value instead of being assignable / overwriteable

  # Shorter helper functions can have shortcuts: &

  # The & operator converts the function that follows into a function. Placeholders &1, &2 etc. correspond to the first, second, and subsequence params. 

  # Ex.: &(&1 + &2) is converted to p1, p2 -> p1 + p2 end

  # Common usage: passing functions to other functions

  # Ex.: Enum.map [1,2,3,4], &(&1 + 1) yields [2,3,4,5]; Enum.map [1,2,3,4], &(&1 + 2) yields [3, 4, 5, 6]
  # Ex.: Enum.map [1,2,3,4], &(&1 < 3)
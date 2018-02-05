# hello.exs
# Hello World in elixir, and also testing Elixir functionality from the Dave Thomas book
# by Eric Mancini
# Execution:
# $ elixir hello.exs

IO.puts "# # # Begin Elixir Test" <> "ing Program Output # # #"
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

  # Some basic boolean stuff

  abcd = 56

  if abcd >= 56 do
    IO.puts "It was true!"
    else 
    IO.puts "It was false!"
  end
  
  # Pattern matching conditionals
  
  # `case` allows us to compare a value against many patterns
  case {:one, :two} do
  {:four, :five} ->
    "This won't match"
    {:one, x} ->
    "This will match and bind `x` to `:two` in this clause"
  _ ->
    "This will match any value"
end

# Modularizing things modularely, generally


# You can group several functions into a module. Inside a module use `def`
# to define your functions.
# (from learnxinyminutes)
defmodule TestMath do
  def sum(a, b) do
    a + b
  end

  def square(x) do
    x * x
  end
end

eph = TestMath.sum(1, 2)  #=> 3
IO.puts eph
eph = TestMath.square(3) #=> 9
IO.puts eph

# Guards: can be used to ensure only certain input is sent to and used by a function

# Multiple function bodies - may look like multiple definitions, purists will "tell you it's multiple clauses of the same definition"
# Works via pattern matching: elixir will call the function until it finds a match (must have the same arity)

# IMPORTANT NOTE of multi-function matching recursive programming patterns:
# Elixir executes /top down/ so order absolutely can matter.
# Keep multiple instances adjacent
# If Anchor / base cases aren't first, you'll at least get warnings and might get infinite loops

# Guard class limitations: Only a subset of elixir can go into guard classes 
# Includes in, some built-in functions, type check functions, join with lieterals, basic arith
# The type check functions: is_atom is_binary is_bitstring is_boolean is_exception is_float is_function is_integer is_list is_map is_number is_pid is_port is_record is_reference is_tuple
# The limit to what can go in a guard is to prevent side effects

# Default parameters: param \\ value syntax
# Like what exists in ES6
# reads left to right

# private functions: defp defines a private function that can only be called within the module declaring it. 

# the pipe operator: |> takes the output of one function and throws it at another
# explicitly: takes teh result of the expression to its left and inserts it as the FIRST param of the function on the right
# Ex.: val |> f(a,b) is basically the same thing as f(val, a, b)
# Separate lines is fine, so is chaining them

IO.puts "Testing the pipe operator:"

eph = (1..10) |> Enum.map(&(&1*&1)) |> Enum.filter(&(&1 < 40))
IO.inspect eph

# parentheses around function parameters in pipelines are very important
# Functional programming transforms data, the |> operator makes those transformations explicit

# Modules: providing namespaces and wrapping macros, structus, protocols, and other modules
# prefixes needed to ref inner module code from outside, but not from inside

defmodule Mod do
  def func1 do
    IO.puts "in func1"
  end
  def func2 do
    IO.puts "in func2"
  end
end

Mod.func1
Mod.func2

defmodule Outer do
  defmodule Inner do
    def inner_func do
    IO.puts "Outer inner inner called"
    end
  end

  def outer_func do
    Inner.inner_func
  end
end

Outer.outer_func
Outer.Inner.inner_func

# A note on lists: lists always end with an empty list, in truly recursive / linked list fashion.

defmodule PipeTest do
  def inc(x) do 
    x + 1
  end
end

IO.puts PipeTest.inc 4 |> PipeTest.inc |> PipeTest.inc

# Let's learn about maps!

# Using @ variables at the start of a function to define defaults or some such is good behavior / a common pattern 

myMap = %{name: "Dave", likes: "Programming"}
Map.keys myMap 
# [ :likes, :name ]

IO.puts Map.values myMap
# ProgrammingDave

IO.puts myMap[:name]

map1 = Map.drop myMap, [:likes]
IO.puts Map.values map1
# "Dave"

map2 = Map.put myMap, :alslo_likes, "Ruby"
IO.puts Map.values map2
# RubyProgrammingDave

IO.puts Map.has_key? map1, :where 
# false

IO.puts Map.has_key? map1, :name
# true

IO.puts " "

# Maps and pattern matching: We most often ask our maps if they have certain keys, values, or key-value pairs.

person = %{ name: "Dave", height: 1.88 }

%{ name: a_name } = person
IO.puts a_name
# "Dave"

# Are there name and key entries?
%{ name: _, height: _ } = person
# Match fail, for example looking for weight, would cause a compiler failure

# destructuring and for 
# the for allows you to pattern match your way through a list. Has a filter and a generator clause.

# simple map updating:

# new_map = %{old_map | key => value,... }
# this will only update the k/v pairs on the right side of the map. Handy!

# What are maps? %{}

# What are structs? More rigid maps, with defaults and/or fixed types.
# A struct is just a module that wraps a limited form of a map.

# see defstruct.exs for an example. It's a module wrapping concepts of the struct.
# Fields can be accessed via dot notation or by pattern matching. 
# The name of the module is the name of the map type.

# structs are wrapped in a module because you are likely to want to add struct-specific behavior
# Compile time checks + default values + bundled functions. Be careful about treating it like
# an entry to object oriented thinking, designing, or coding!

# nested dictionaries have helpers, like put_in
# put_in is not magic! It is a macro that generates long-winded code to match and update more deeply in the struct
# Also exist: get_in and get_and_update_in 

# this code not behaving as expected?
# commands work logically in iex...
IO.puts "Company, before put_in: "
report = %{ owner: %{ name: "Dave", company: "Pragmatic" }, severity: 1}
IO.puts report.owner.company
# put_in(report[:owner][:company], "Dragon")
put_in(report.owner.company, "Dragon")
IO.puts "Company, after put_in update: "
IO.puts report.owner.company
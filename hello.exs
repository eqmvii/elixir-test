# hello.exs
# Hello World in elixir, and also testing Elixir functionality from the Dave Thomas book
# by Eric Mancini
# Execution:
# $ elixir hello.exs

# file extension types with elixir:
# .exs is an elixir script file, and is interpreted
# .ex is a compiled elixir file

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

IO.puts "Company, before put_in: "
report = %{ owner: %{ name: "Dave", company: "Pragmatic" }, severity: 1}
IO.puts report.owner.company
# Note the return = at the beginning here. Functional language, so nothing is ever modified in place.
# report = put_in(report[:owner][:company], "Dragoooon")
report = put_in(report.owner.company, "Walrus")
IO.puts "Company, after put_in update: "
IO.inspect report

# IO.inspect is basically IO.puts for more complex data types

# maps and structs are dictionary types

# Sets are implemented via the MapSet module

# With great power comes great temptation. DO NOT USE STRUCTS FOR OBJECT ORIENTED PARADIGM CODING.

# What are types?

# Keyword is a type, for example, but on an implementation level it is a list of tuples. List functions still work on it.

# Processing Collections - Enum & Stream. CHapter 10, page 95

# Things that can be iterated implement Enumerable protocol

# A broad overview of things that Enum can do for you:

'''
Turn collections into lists
Concatenate c ollections
Create collections whose elements are some function of the original 
A million other things
'''

# slick example of using collections and for to do a deck of cards
IO.puts "Deck of cards example: "
deck = for rank <- '23456789TJQK', suit <- 'CHDS', do: [suit, rank]
IO.inspect deck

# Shuffle and such
hand = deck |> Enum.shuffle |> Enum.take(5)

# Piping and introducing streams

prestreamlist = [1,2,3,4,5]
Enum.map(prestreamlist, &(&1*&1)) |> Enum.with_index |> Enum.map(fn {value, index} -> value - index end) |> IO.inspect

# Observe that piping sends things into the next function as the first argument
# Here Enum is taking and also returning a collection, which is insufficiently efficient
# Streams allow for passing things directly without creating intermediate lists
# That is efficient and important! 

# A stream is a composable enumerator 
s = Stream.map [1,3,5,7], &(&1 + 1)
#Stream<[enum: [1, 3, 5, 7], funs: [#Function<48.71542911/1 in Stream.map/2>]]>

# To get that back to a useable list, feed it to Enum
quaileggs = Enum.to_list s
IO.inspect quaileggs

# Streams can be passed to streams, and as such are composable

# Streams are !$&^ magic. THis would take 8 seconds to run:
# Enum.map(1..10_000_000, &(&1+1)) |> Enum.take(5)
# whereas this takes imperceptible time:
# Stream.map(1..10_000_000, &(&1+1)) |> Enum.take(5) 

# readibility note: yes, large numbers can contain underscors to make it more visually obvious
# that they are really gigantic. It should be pure symantics/style, however.

# Lots of infinite and looping and iterating use cases of streams exist

# Here have some code 
# Stream.iterate(0, &(&1+1)) |> Enum.take(500)

# unfold takes an initial value and a function. It then returns a value and passes another forward into a potential infinite stream
# Stream.unfold({0,1}, fn {f1,f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(15)
# Stream.resource takes it even further.

# The Collectable Protocol - the opposite of Enumerable, which gets elements/items from collections.
# Colectable lets the user build collections from elements/items.

# Comprehensions: Elixir life-make-easier / shortcut for map and filter commands on collections of things
# Example:

IO.puts "\nFiltering and maping examples\n"
for x <- [1,2,3,4,5], do: IO.puts x * x
for x <- [1,2,3,4,5], x < 4, do: IO.puts x * x

# generator specifies extraction from a collection
# pattern <- enumerable_thing
# Multiple generators nest instead of paraleliterate

# Complex example:

first8 = [1,2,3,4,5,6,7,8]
for x <- first8, y <- first8, x >= y, rem(x*y, 10)==0, do: IO.inspect {x,y}
# That will show every x,y combo from 1 to 8 for each of x and y where x is larger than y and they multiply together to a multiple of 10
# how many times does this iterate? 64 - it nests through 1 and 8 in each direction.
# First term in a generator is a pattern and as such can be used to deconstruct 

# recursion and enumeration
# It's fun to recurse for recursions sake, but day-to-day work is best done with enumerators built into Elixir
# That might mean recursion under the hood, but it doesn't require writing freshly recursive code routinely.
# Dave thomas recommends enumerating whenever possible and he wrote the book, so.

IO.puts "\nStrings and Binaries\n"
# Single vs. double quoted strings
# interpolation: #{}

interponame = "Eric"
IO.puts "Hello #{interponame} how are you today"

# excaping can happen with a backslash
# strings can span several lines. IO.write doesn't append new lines

IO.puts "Start"
IO.write "
  my
  st
  ring
  "

IO.puts "End."

# heredoc notation fixes this though. So hooray! Use triple quotation marks and indentation to accomplish that.
# heredoc notation is used for documentation on functions and modules

# sigils are symbols with magical power. tilde, letter, content, and options. Examples:
# C is no escape/interp, c is single qupte string, D is date, N is native date, R  and r do regexp, S and s change escape, T is time, etc. 
# You can even define your own, because of course you can.

# Strings vs. character lists
# In Elixir, only double quotes create strings. Single quotes create, instead, character lists.
# The libraries and usages can be very different. Single quoted are just lists of character codes.

str = 'wombat'
IO.puts is_list str
IO.puts length str
IO.puts Enum.reverse str
IO.puts [ 67, 65, 84 ]
# CAT

# See that iex is treating any list of integers that could be character codes as though they for sure are when it comes to printing
# if characters are considered nonprintable, then IEX will default to the list-of-integers interpretation 
# Because a character list is a real list, pattern matching list functionality will work.

'pole' ++ 'vault' # polevault
# "pole" ++ "vault" # ArgumentError
'pole' -- 'vault' # poe
[head | tail ] = 'cat' # [ c | at ] -> 'cat'
head # 99, since cat is an integer list and 99 is c
?c # 99, returns the char code

# binaries represent sequences of bits
b = << 1, 2, 3 >>
IO.inspect b
IO.puts byte_size b # 3
IO.puts bit_size b # 24
# edit for shell script test

# String as a technical term really does mean string, as in a double quoted string.
# String module is for double quoted strings only
# grapheme: small unit of writing
# A number of useful library methods exist for manipulating strings - caps, location, reverse, etc. 
# lowercase is downcase because of course it is.
# jaro_distance uses magic to determine how similar two strings are

IO.puts String.replace "the cat on the mat", "at", "WALRUS!!!!"
# "the cWALRUS!!!! on the mWALRUS!!!!"

# Control flow
IO.puts "\nControl Flow: Coming later because we use if less due to pattern matching and multi-arity functions\n"

# Elixir code tries to be declarative, not imperative 
# Small functions, guard clauses, and pattern matching /replaces most control flow/
# Pattern matching is the functional alternative to if/else/etc. control flow
# Functions without control flow are easier to test, read, and reuse. 
# 10 or 20 line elixir function? It probably has a construct and can probably be shortened/undone.

# if and else, under the hood:
# if and the evil twin unless take a condition and a /keyword list/. The do: keyword list code is executed on true,
# the else: keyword list is executed otherwise. The else: branch isn't necessary. 
# Syntax highlighting can throw you off, it's actually very basic and simple.

# if 1 == 1, do: IO.puts "true part", else: "false part"
# if and else then have syntactic sugar that look like function declarations
# if 1 == 1 do
#   IO.puts "true part"
# else
#   IO.puts "false part"
# end

# cond executes code after looking for that which is truthy 
# a series of conditions and you choose the one that is truthy to do

# case - testing values against patterns, first match gets a return. Includes guard clauses
# Case is extremely powerful because of pattern matching. JavaScript has switch/case but it isn't nearly as cool and doesn't do this.

# Raising exceptions:
# in Elixir, exceptions are things that should literally never happen. They are not boolean-style control flow operations.
# simple form:
# raise "giving up"
# produces
# ** (RuntimeError) giving up

# error convention: trailing exclamation mark means failure will raise a meaningful exception, and that's all that's needed
# many built in functions have a normal form that returns a status touble and an ! form that raises and exception upon failure

# The philosophy of pipe: instead of deeply nested things where you have to understand them right-to-left and inside-out,
# pipe allows you to see the natural flow of data along a path of transformation.

# Tools, tooling and projects

# mix is the BUILD TOOL for Elixir projects
# hex is the PACKAGE MANAGER

# mix copies external libraries into the project's directory structure. 
# be aware of OTP and mix.exs configurations for OTP application. 
# Many things that would be libraries in other languages/paradigms
# are actually subapplications, such that the entire app 
# is actually a suite of cooperating subapplications
# Think: components or services

# config.exs will eventually contain key/value pairs of configuration variables for the application.

# Pattern matching as a test using a question mark:
# A pattern match with a question mark at the end will do the thing if it matches, and otherwise fail silently if it doesn't. 
# There is a chance this is phoenix specific?

# Keyword lists, revisited, now with more specificity:
# A list of tuples where the first item in each tuple is an item can be sugared into a keyword list. Example:

a = [{:name, "Eric" }, {:Age, 30 }, {:tall, :no} ]
IO.inspect a
# [name: "Eric", Age: 30, tall: :no]
b = [name: "Eric", Age: 30, tall: :no]
IO.inspect a == b
# true
c = [{:name, "Eric"}, {:age, 30}, {"Eric", "David", "Martin"}]
IO.inspect c
# [{:name, "Eric"}, {:age, 30}, {"Eric", "David", "Martin"}]
# See that because the keyword list doesn't exactly respect the rules, the automatic covnversion can't / doesn't happen

# keyword lists have limitations: they approximate pure key-value pairing data structures as in other programming languages, but require all keys to be atoms.
# If keys cannot simply be atoms, then a real map is required 

# Now, then, to revisit: what are tuples?
# tuples are lists of values stored in curly braces like so {}
# But critically, they are contiguous blocks of memory, and so can be accessed via elem

tuple_test = {"hello", 24, :charlie, [1,2,3]}
IO.inspect elem(tuple_test, 0)
# "hello"
IO.inspect elem(tuple_test, 1)
# 24
IO.inspect elem(tuple_test, 2)
# :charlie
IO.inspect elem(tuple_test, 3)
# [1, 2, 3]
IO.inspect tuple_size(tuple_test)
# 4

# when and why on tuples? often enriched values, values that have some additional context/status information associated with them

# Magic in the enumerable protocol:

# The enumerable protocol requires just three functions: count(collection), member?(collection, value) and reduce(collection, acc, fun).
# If that protocol is implemented, then all of the built in Enum functions can work, and that's honestly seriously cool
# returning an error for member is actually OK and signifies no quick way to proceed, leaving enumerable code to do a linear search

# As for reduce: some magic is included to handle the case of streams. The accumulator itself is a tuple, the first element of which is :cont, :halt or :suspend
# the second is the actual accumulator value.
# The value of reduce itself is also a tuple include its state: :done, :halted, or :suspended

# But what about the other way - implementing the collectable protocol allows for some built-in functions to work in reverse,
# i.e. Enum.into 

# Why the complexity in the enumerable/collectable protocols?
# Because it allows eager and lazy, i.e. enum and stream, implementations. Complicated, but powerful!

# umbrella projects and apps: 
# a mix project made with --umbrella creates an apps folder, and then individual mix projects can be made inside of thee apps folder
# The "app" name is probably wrong, it's much more like a shared library than it is like a full singular application

# revisiting error handling: exceptions are raised, but rarely caught. Processess should just die, and then be dead, supervised, restarted, etc.
# Exceptions should be reservee for things that are "truly exceptional" - i.e. rare, basically never happen, etc.

# iex 
# raise "Giving up"
# ** (RuntimeError) giving up

# iex(1)> raise RuntimeError, message: "This is the override message"
# ** (RuntimeError) This is the override message

# Types and the @spec module
# @spec module allows documenting types in a nice readable way for inline and for other usage.

# What are the elixir types?
# any, atom, char_list (single quote string), float, fun, integer, map, none, pid, port, reference, and tuple.

# Note also that you can use as_boolean(T), for example, for truthiness

# Definining new types: The @type syntax can be used to define new types
# predefined examples:
# @type boolean :: false | true
# @type byte :: 0..255
# @type list :: [ any ]

# and can be parameterized
# @type list(t) :: [ t ]  
# @type list(integer) is another example?

# See notes here for a list of types
# https://hexdocs.pm/elixir/typespecs.html#notes

# types can also be privatized or opauqe (sem-pseudo visible)
# @typep
# @opaque

# type spec with functions: !!! IMPORTANT !!!

# @spec function_name(param1_type, ...) :: return_type
# actual function definition

# what about t
# it might stand for collection? type of a collection?

# Types enable gaurding using Dialyzer, from the erlang days


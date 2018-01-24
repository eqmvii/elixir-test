# Elixir notes and tests

## Install / variable notes

export PATH="$PATH:/path/to/elixir/bin" (re-do next time?)

Theoretically now sitting on Elixir 1.5.2 installed; yay!

Wrote hello world. Run with:

'''
$ elixir simple.exs
'''

## Commands

start the interactive shell:
iex

quit:
ctrl-c twice, or ctrl-g and then q

iex help:
h

variable info:
i
(ex: i 123 tells you that it's an integer)

Compile + run source code:
elixir [program_name.exs]

compile in iex:
x "programname.exs"

## Syntax / language notes

Matching makes the left side try to fit the right side
_ is a wildcard
^ is the pin operator, to force left-hand variables to stay the same
Theory: the equals sign works like it does in algebra, it doesn't automatically assign so much as it tries to make work.

Immutability:
In Elixir, all data is immutable
(but variables /can/ be rebound)
Transformation at heart: Any function that transforms data will return a copy.

Types:

Values: 
* Integers
* Floating points
* Atoms
* Ranges
* Regular expressions

System types:
* PIDs and Ports
* References

Collection types:
* Tuples
* Lists
* Maps
* Binaries

Functions are their own type

Atoms: constants that represent something's name

Tuples: bracketed lists of values, usually 2 to 4. Commonly with an :ok return.

Lists: not a lot like arrays in other languages; recursively defined with the tail also being a list.
* Membership (in)
* Concatenation ++
difference -- 

From SO: 

"The way to think about it is that Lists are open-ended data structures and their size can vary at runtime while Tuples have a constant size set at compile time."

Tuples should be thought of as single pieces of data, not things to be iterated over.

Lists of two-value tuples as a shortcut

Maps: Starts with %, lists of key/value pairs.
%{ key => value, key => value }

Maps are the main associative array

Truthiness exists! true, false, and nil.

Strict and value equality.

and / or are boolean, || / && are relaxed and treat many arguments as truthy (i.e. not nil or false)

div(a,b) for integer division

## Scope

Lexical scope, local to functions

with keyword: defines local scope

~~~~
<-
~~~~

returns unmatched element when inside a with

iex> with [a|_] <- [1,2,3], do: a
1

The value of with is the value of its "do" parameter at the end

## Functions

fn to create anonymous functions

fn
   something
end

(P49 on list, 64 of 348 @ Function Calls and Pattern Matching)

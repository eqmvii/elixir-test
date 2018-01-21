Testing various elixir things

Progress: 

Installed/updated erlang (not esl-erlang?)

installed/updated elixir

export PATH="$PATH:/path/to/elixir/bin" (re-do next time?)

Theoretically now sitting on Elixir 1.5.2 installed; yay!

Wrote hello world. Run with:

'''
$ elixir simple.exs
'''

Command notes:

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

General notes:

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

(P22)

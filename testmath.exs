# testmath.exs
# a module test from learnxinyminutes

# defp would allow a function inside of a module to be private 

# You can group several functions into a module. Inside a module use `def`
# to define your functions.
defmodule Math do
  def sum(a, b) do
    a + b
  end

  def square(x) do
    x * x
  end
end

Math.sum(1, 2)  #=> 3
Math.square(3) #=> 9
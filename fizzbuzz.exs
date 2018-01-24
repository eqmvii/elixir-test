# fizzbuzz.exs
# Write a function that takes three arguments. 
# If the first two are zero, return fizzbuzz. 
# If the first is zero, return Fizz. 
# If the second is zero, return "buzz." Otherwise return the third argument.

fizzbuzz = fn 
    {0, 0, _} -> "FizzBuzz"
    {0, _, _} -> "Fizz"
    {_,0,_} -> "Buzz"
    {_,_,a} -> a
    end

IO.puts(fizzbuzz.({0,0,0}))
IO.puts(fizzbuzz.({0,8,1}))
IO.puts(fizzbuzz.({1,0,1}))
IO.puts(fizzbuzz.({1,2,2}))
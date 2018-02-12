# tasks1.exs
# tasks and async in elixir

defmodule Fib do
    def of(0), do: 0
    def of(1), do: 1
    def of(n), do: Fib.of(n - 1) + Fib.of(n-2)
end

IO.puts "Start the task..."
worker = Task.async(fn -> Fib.of(39) end)
IO.puts "Do something else! In the interim!"
math = 5 * 5 * 5 * 5 *5
IO.inspect math
IO.puts "Time passes."
result = Task.await(worker)

IO.puts "The result is #{result}"
# spawn4.exs
# Longer lasting?

defmodule Spawn4 do
    def greet do
        receive do
            {sender, msg} ->
                send sender, { :ok, "Hello, #{msg}" }
                # this is the magic infinite loop of the concurent process
                greet
        end
    end
end

# here's a client
pid = spawn(Spawn4, :greet, [])
send pid, {self(), "World!"}

receive do
    {:ok, message} ->
        IO.puts message
end

send pid, {self, "Kermit!"}
receive do
    {:ok, message} ->
        IO.puts message
    after 2500 ->
        IO.puts "The greeter has gone away"
end
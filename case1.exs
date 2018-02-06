# case1.exs
# pattern matching with case

dave = %{ name: "Dave", state: "TX", likes: "programming" }
charles = %{name: "Charles", status: "Amazing"}

case dave do
    %{state: some_state} = person ->
        IO.puts "#{person.name} lives in #{some_state}"
    _ -> 
        IO.puts "No matches found in case statement, sorry."
end

case charles do
    %{state: some_state} = person ->
        IO.puts "#{person.name} lives in #{some_state}"
    _ -> 
        IO.puts "No matches found in case statement, sorry."
end
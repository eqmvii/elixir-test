# case.exs

case File.open("hellototheworld.exs") do
    { :ok, file } ->
        IO.puts "First line of file: #{IO.read(file, :line)}"
    { :error, reason } ->
        IO.puts "Failed to open file: #{reason}"
end
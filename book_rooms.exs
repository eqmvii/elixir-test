# book_rooms.exs
# pattern matching and data structure example

# usage example: 
'''

HotelRoom.book(%{name: "Eroc", height: 2})

HotelRoom.book(%{name: "Kaarl", height: 1.5})

HotelRoom.book(%{name: "David", height: 1})


'''

defmodule HotelRoom do
    
    def book(%{name: name, height: height})
    when height > 1.9 do
        IO.puts "Need extra long bed for #{name}"
    end
    
    def book(%{name: name, height: height})
    when height <1.3 do
        IO.puts "Need a short bed for #{name}"
    end

    def book(person) do
        IO.puts "Need regular bed for #{person.name}"
    end
end
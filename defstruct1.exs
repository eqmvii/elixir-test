# defstruct1.exs
# example of structs with associated functions/methods
# this smells awfully object oriented?

defmodule Attendee do
    defstruct name: "", paid: false, over_18: true

    def may_attend_after_party(attendee = %Attendee{}) do
        attendee.paid && attendee.over_18
    end

    def print_vip_badge(%Attendee{name: name}) when name != "" do
        IO.puts "Very cheap badge for #{name}"
    end

    def print_vip_badge(%Attendee{}) do
        raise "missing name and cannot print badge"
    end
end


# usage

'''
iex(1)> a1 = %Attendee{name: "Dave", over_18: true}
%Attendee{name: "Dave", over_18: true, paid: false}
iex(1)> a2 = %Attendee{name: "Eric", over_18: true}
%Attendee{name: "Eric", over_18: true, paid: false}
iex(2)> Attendee.print_vip_badge(a2)
Very cheap badge for Eric
:ok
iex(3)> a3 = %Attendee{}
%Attendee{name: "", over_18: true, paid: false}
iex(4)> Attendee.print_vip_badge(a3)
** (RuntimeError) missing name and cannot print badge
    defstruct1.exs:17: Attendee.print_vip_badge/1

'''

# is it NOT object oriented because the function is only associated with the module and not with the actual struct/object itself?
xml.instruct!
xml.Response do
    xml.Gather(:action => @post_to, :numDigits => 1) do
        xml.Say "Hello this is a call from C trip.  Mr wu want to booking a private pool villa. He will stay at the hotel from Wed 25 to Fri 27"
        xml.Say "Please press 1 to repeat this menu. Press 2 for make a deal. Or press 3 if the rooms are fully booked!"
    end
end
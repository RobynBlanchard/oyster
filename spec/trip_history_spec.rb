require "trip_history"
require "oyster"

describe TripHistory do
   describe '#new' do
     it "takes a customer id and creates an instance of TripHistory" do
       customer_id = 1
       trip_history = TripHistory.new(1)
       expect(trip_history).to be_instance_of(TripHistory)
     end
   end
end

require "journey_history"
require "oyster"

describe JourneyHistory do
   describe '#new' do
     it "takes a customer id and creates an instance of TripHistory" do
       customer_id = 1
       trip_history = TripHistory.new(1, [])
       expect(trip_history).to be_instance_of(TripHistory)
     end
   end

   describe '#add_journey' do
     before(:each) do
       customer_id = 1
       @start_zone = 1
       @end_zone = 1
       @fare = 1.7
       @trip_history = TripHistory.new(1)
       @trip_history.save(@start_zone, @end_zone, @fare)
     end
     context "customer has taken their first journey" do
       it "saves the journey" do
         expect(@trip_history.trips.first).to eq({
           "start_zone"=> @start_zone,
           "end_zone"=> @end_zone,
           "fare"=> @fare})
       end
     end

     context "customer has already taken atleast one journey before" do
        it "saves the journey" do
          start_zone = 2
          end_zone = 3
          fare = 1.7
          @trip_history.save(start_zone, end_zone, fare)
          expect(@trip_history.trips).to eq([
            {"start_zone"=> @start_zone,
            "end_zone"=> @end_zone,
            "fare"=> @fare},
            {"start_zone"=> start_zone,
            "end_zone"=> end_zone,
            "fare"=> fare}
            ])
        end
     end
   end
end

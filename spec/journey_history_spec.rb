require "journey_history"
require "journey"
require "oyster"

describe JourneyHistory do
   let(:journey) { double(Journey) }
   subject { described_class.new() }

   describe "#new" do
     it "defaults the journeys to an empty array" do
       expect(subject.journeys).to eq []
     end

     it "accepts a journey at creation" do
       journey_history = JourneyHistory.new(journey)
       expect(journey_history.journeys).to eq journey
     end
   end

   describe '#add_journey' do
     before(:each) do
       subject.add(journey)
     end

     context "no previous journeys" do
       it "it adds a journey to journeys" do
         expect(subject.journeys[0]).to eq journey
       end
     end

     context "one previous journey" do
       let(:journey2) { double(Journey) }

       it "it adds the journey to journeys" do
         subject.add(journey2)
         expect(subject.journeys[1]).to eq journey2
         expect(subject.journeys[0]).to eq journey
       end
     end
   end
end

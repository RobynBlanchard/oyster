require "journey"

describe Journey do
  describe '#new' do
    it "takes two parameters and returns a journey object" do
      balance = 50
      start_zone = rand(1...5)
      journey = Journey.new(balance, start_zone)
      expect(journey).to be_instance_of(Journey)
    end
  end

  describe '.minimum_fare' do
    it "returns an integer" do
      result = Journey.minimum_fare
      expect(result).to eq(1.7)
    end
  end

  describe '#calculate_fare' do
    it "calculates the fare given two zones (1 and 3)" do
      balance = 50
      start_zone = 1
      end_zone = 3
      journey = Journey.new(balance, start_zone)
      fare = journey.calculate_fare(end_zone)
      expect(fare).to equal(3.3)
    end

    it "calculates the fare given two zones (1 and 1)" do
      balance = 50
      start_zone = 1
      end_zone = 1
      journey = Journey.new(balance, start_zone)
      fare = journey.calculate_fare(end_zone)
      expect(fare).to equal(2.4)
    end

    it "calculates the fare given two zones (2 and 5)" do
      balance = 50
      start_zone = 2
      end_zone = 5
      journey = Journey.new(balance, start_zone)
      fare = journey.calculate_fare(end_zone)
      expect(fare).to equal(2.8)
    end
  end
end

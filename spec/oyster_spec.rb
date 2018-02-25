# spec/oyster_spec.rb
require "oyster"
require "journey"

describe Oyster do
  describe "#new" do
    it "takes one customer parameter and returns an oyster object" do
      oyster = Oyster.new(1)
      expect(oyster).to be_instance_of(Oyster)
    end

    it "takes two parameters and returns an oyster object" do
      oyster = Oyster.new(50, 1)
      expect(oyster).to be_instance_of(Oyster)
    end

    it "takes no parameters and returns an error" do
      expect { raise Oyster.new() }.to raise_error(ArgumentError)
    end
  end

  describe "#top_up" do
    before(:each) do
      @oyster = Oyster.new(1)
    end

    context "top up amount is less than max top up amount" do
      it "increases the Oyster balance" do
        amount = rand(0..50)
        @oyster.top_up(amount)
        expect(@oyster.balance).to equal(amount)
      end
    end

    context "top up amount is greater than max top up amount" do
      it "does not increase the Oyster balance" do
        amount = rand(51..999)
        @oyster.top_up(amount)
        expect(@oyster.balance).to equal(0)
      end
    end
  end

  describe "#deduct_fare" do
    it "deducts the fare amount from the balance" do
      balance = 50
      fare_amount = 20
      @oyster = Oyster.new(balance, 1)
      @oyster.deduct_fare(fare_amount)
      expect(@oyster.balance).to equal(balance-fare_amount)
    end
  end

  describe "#tap_in" do
    let(:new_journey) { double(:journey) }
    let(:zone) { 1 }

    context "oyster balance is less than the minimum fare" do
      it "does not create a new journey" do
        oyster = Oyster.new(0, 1)
        oyster.tap_in(:zone)
        # add expectation
      end
    end

    context "oyster balance is greater than the minimum fare" do
      it "creates a new journey" do
        oyster = Oyster.new(5, 1)
        oyster.tap_in(:zone)
        balance = 5
        allow(Journey).to receive(:zone).and_return(:new_journey)
        #expect(Journey).to receive(:new).with(balance).and_return(:new_journey)
      end
    end
  end

  describe "#tap_out" do
    balance = 50
    before(:each) do
      @oyster = Oyster.new(balance, 1)
    end

    it "deducts a fare for the journey from the Oyster balance" do
      calculated_fare = rand(1.7...4.7)
      allow_any_instance_of(Journey).to receive(:calculate_fare).and_return(calculated_fare)
      @oyster.tap_in(:start_zone)
      @oyster.tap_out(:end_zone)
      expected_balance = balance - calculated_fare
      expect(@oyster.balance).to equal(expected_balance)
    end
  end
end

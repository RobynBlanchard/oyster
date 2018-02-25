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

    it "does not tap in if balance is less than minimum fare" do
      oyster = Oyster.new(0, 1)
      oyster.tap_in
    end

    it "does tap in if balance is not less than minimum fare" do
      oyster = Oyster.new(5, 1)
      oyster.tap_in
      balance = 5
      allow(Journey).to receive(:balance).and_return(:new_journey)
      #expect(Journey).to receive(:new).with(balance).and_return(:new_journey)
    end
  end

  describe "#tap_out" do
    oyster = Oyster.new(50, 1)
    oyster.tap_out
  end
end

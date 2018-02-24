# spec/oyster_spec.rb
require "oyster"

describe Oyster do
  describe "#new" do
    it "takes one customer parameter and returns an oyster object" do
      oyster = Oyster.new(customer_id: 1)
      expect(oyster).to be_instance_of(Oyster)
    end

    it "takes two parameters and returns an oyster object" do
      oyster = Oyster.new(balance: 50, customer_id: 1)
      expect(oyster).to be_instance_of(Oyster)
    end

    it "takes no parameters and returns an error" do
      expect { raise Oyster.new() }.to raise_error(ArgumentError)
    end
  end

  describe "#top_up" do
    before(:each) do
      @oyster = Oyster.new(customer_id: 1)
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

end

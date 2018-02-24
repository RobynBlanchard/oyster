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
end

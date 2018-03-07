require "oyster"
require "journey"

describe Oyster do
  let(:balance) { 0 }
  subject { described_class.new(balance: balance) }

  describe "#new" do
    it "defaults the balance to zero" do
      oyster = described_class.new
      expect(oyster.balance).to eq 0
    end

    let(:balance) { 40 }

    it "accepts a balance at creation" do
      expect(subject.balance).to eq 40
    end

    it "does not allow more than the max balance" do
      #TODO
    end
  end

  describe "#top_up" do
    context "top up amount is less than max top up amount" do
      let(:amount) { 40 }

      it "increases the Oyster balance" do
        subject.top_up(amount)
        expect(subject.balance).to equal(amount)
      end
    end

    context "top up amount is greater than max top up amount" do
      let(:amount) { 55 }

      it "does not increase the Oyster balance" do
        expect { subject.top_up(amount) }.to raise_error(MaxTopUpError)
      end
    end
  end

  describe "#tap_in" do
    let(:journey) { double(:journey) }
    let(:zone) { 1 }

    context "oyster balance is less than the minimum fare" do
      it "raises an BalanceBelowRequiredError" do
        expect { subject.tap_in(zone) }.to raise_error(BalanceBelowRequiredError)
      end
    end

    context "oyster balance is greater than the minimum fare" do
      let(:balance) { 40 }

      it "creates a new journey" do
        # Improvements:
        # .with specific args
        # Check return value
        expect(subject).to receive(:start_journey)
        subject.tap_in(zone)
      end
    end
  end

  describe "#tap_out" do
    let(:balance) { 50 }
    let(:start_zone) { 1 }
    let(:end_zone) { 4 }

    context "a valid journey with no prior journeys" do
      let(:calculated_fare) { 2 }
      
      before(:each) do
        allow_any_instance_of(Journey).to receive(:calculate_fare).and_return(calculated_fare)
        subject.tap_in(start_zone)
        subject.tap_out(end_zone)
      end

      subject.journey

      it "deducts a fare for the journey from the Oyster balance" do
        expect(subject.balance).to equal(48)
      end
    end

    # context "customer failed to tap in" do
    #   let(:journey) { Journey.new(balance, 1)}
    #   let(:calculated_fare) { 2.4 }

    #   it "applies a penalty fare" do
    #     oyster.tap_out(1)
    #     allow(Journey).to receive(:new).and_return(journey)
    #     allow_any_instance_of(Journey).to receive(:calculate_fare).and_return(calculated_fare)
    #     expected_balance = balance - (Journey.penalty_fare + calculated_fare)
    #     expect(oyster.balance).to eq(expected_balance)
    #   end
    # end
  end
end

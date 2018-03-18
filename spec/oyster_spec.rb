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
    let(:balance) { 40 }
    let(:zone) { 1 }

    context "oyster balance is less than the minimum fare" do
      let(:balance) { 0 }
      it "raises an BalanceBelowRequiredError" do
        expect { subject.tap_in(zone) }.to raise_error(BalanceBelowRequiredError)
      end
    end

    context "customer has no incomplete prior journeys" do
      it "creates a journey" do
        subject.tap_in(start_zone: zone)
        expect(subject.journey).to be_truthy
      end
    end

    context "customer did not tap out on previous journey" do
      before(:each) do
        subject.tap_in(start_zone: zone)
        subject.tap_in(start_zone: zone)
      end

      it "adds a journey to the journey history with nil as the end zone" do
        expect(subject.journey_history.journeys.count).to eq 1
        expect(subject.journey_history.journeys.first.end_zone).to be_nil
      end

      it "creates a new journey" do
        expect(subject.journey).to be_truthy
      end
    end
   end

  describe "#tap_out" do
    let(:balance) { 50 }
    let(:end_zone) { 4 }

    context "a valid journey with no prior journeys" do
      let(:start_zone) { 1 }
      let(:calculated_fare) { 2 }

      before(:each) do
        allow(subject).to receive(:end_journey).and_return(calculated_fare)
        subject.tap_in(start_zone: start_zone)
        subject.tap_out(end_zone)
      end

      it "deducts a fare for the journey from the Oyster balance" do
        expect(subject.balance).to eq 48
      end

      it "adds a journey to the journey history" do
        expect(subject.journey_history.journeys.count).to eq 1
      end

      it "sets the instance of Journey to nil" do
        expect(subject.journey).to be_nil
      end
    end

    context "customer failed to tap in" do
      let(:start_zone) { nil }
      let(:calculated_fare) { 5 }

      before(:each) do
        allow(subject).to receive(:end_journey).and_return(calculated_fare)
        subject.tap_in(start_zone: start_zone)
        subject.tap_out(end_zone)
      end

      it "deducts a fare for the journey from the Oyster balance" do
        expect(subject.balance).to eq 45
      end

      it "adds a journey to the journey history" do
        expect(subject.journey_history.journeys.count).to eq 1
      end

      it "sets the instance of Journey to nil" do
        expect(subject.journey).to be_nil
      end
    end
  end
end

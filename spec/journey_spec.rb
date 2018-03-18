require "journey"

describe Journey do
  let(:start_zone) { 1 }
  let(:end_zone) { 3 }
  let(:fare) { 5 }

  subject { described_class.new(start_zone: start_zone) }

  describe "#new" do
    it "accepts a start zone at creation" do
      expect(subject).to be_instance_of(described_class)
    end
  end

  describe "#end_journey" do
    before(:each) do
      allow(subject).to receive(:calculate_fare).and_return(fare)
    end

    context "start zone is nil" do
      let(:start_zone) { nil }

      it "returns a fare with a penalty" do
        expect(subject.end_journey(end_zone)).to eq fare + 4.7
      end

      it "sets the journey end_zone value" do
        subject.end_journey(end_zone)
        expect(subject.end_zone).to eq(end_zone)
      end

      it "sets the journey fare value" do
        subject.end_journey(end_zone)
        expect(subject.fare).to eq(fare + 4.7)
      end
    end

    context "end zone is nil" do
      let(:end_zone) { nil }

      it "returns a fare with a penalty" do
        expect(subject.end_journey(end_zone)).to eq fare + 4.7
      end

      it "sets the journey end_zone value" do
        subject.end_journey(end_zone)
        expect(subject.end_zone).to be_nil
      end

      it "sets the journey fare value" do
        subject.end_journey(end_zone)
        expect(subject.fare).to eq(fare + 4.7)
      end
    end

    context "start zone and end zone are not nil" do
      it "returns a non penalty fare" do
        expect(subject.end_journey(end_zone)).to eq fare
      end

      it "sets the journey end_zone value" do
        subject.end_journey(end_zone)
        expect(subject.end_zone).to eq(end_zone)
      end

      it "sets the journey fare value" do
        subject.end_journey(end_zone)
        expect(subject.fare).to eq(fare)
      end
    end
  end
end

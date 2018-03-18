require "journey"

describe Journey do
  let(:balance) { 50 }
  let(:start_zone) { 1 }
  let(:end_zone) { 3 }

  subject { described_class.new(start_zone: start_zone) }

  describe "#new" do
    it "takes two parameters and returns a journey object" do
      expect(subject).to be_instance_of(described_class)
    end
  end

  describe "#calculate_fare" do
    let(:fare) { subject.calculate_fare(end_zone) }

    it "calculates the fare given two zones (1 and 3)" do
      expect(fare).to eq(3.3)
    end

    context "between 1 and 1" do
      let(:end_zone) { 1 }

      it "calculates the fare given two zones (1 and 1)" do
        expect(fare).to equal(2.4)
      end
    end
  end

  # describe "#calculate_penalty_fare" do
  #   # let(:fare) { subject.calculate_penaltry_fare(end_zone) }
  #
  #   #TODO
  # end
end

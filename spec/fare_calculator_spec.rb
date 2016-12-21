require './lib/fare_calculator.rb'

describe FareCalculator do

  subject(:fare) { described_class.new }
  let(:other_station) { double :other_station }
  let(:station) { double :station }

  context "fare method" do

    it "calculates a fare for zone 1 to zone 1" do
      update_zones(1,1)
      expect(subject.fare(station, other_station)).to eq 1
    end

    it "calculates a fare for zone 1 to zone 2" do
      update_zones(1,2)
      expect(subject.fare(station, other_station)).to eq 2
    end

    it "calculates a fare for zone 3 to 5" do
      update_zones(3,5)
      expect(subject.fare(station, other_station)).to eq 3
    end

    it "calculates a fare for zone 6 to 3" do
      update_zones(6,3)
      expect(subject.fare(station, other_station)).to eq 4
    end

    it "returns penalty fare when not touched in" do
      station = "No touch in"
      expect(subject.fare(station, other_station)).to eq FareCalculator::PENALTY_FARE
    end

    it "returns penalty fare when not touched out" do
      other_station = "No touch out"
      expect(subject.fare(station, other_station)).to eq FareCalculator::PENALTY_FARE
    end

    def update_zones(entry_zone, exit_zone)
      allow(station).to receive(:zone).and_return entry_zone
      allow(other_station).to receive(:zone).and_return exit_zone
    end
  end

end

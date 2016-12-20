require 'journey.rb'

describe Journey do

  let(:journey) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station)}

  context "fare method" do

    it "should respond to fare" do
      expect(journey).to respond_to(:fare)
    end

    it "should return penalty fare if no entry station on touch out" do
      journey2 = Journey.new
      journey2.touch_out("Hammersmith")
      expect(journey2.fare).to eq Journey::PENALTY_FARE
    end

    it "should return minimmum fare" do
      journey.touch_in("Hammersmith")
      journey.touch_out("Bank")
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end
  end

end

require './lib/journey.rb'

describe Journey do

  let(:journey) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  context "initializing" do
    it "should initialize an empty single journey" do
      expect(journey.single_journey).to eq({})
    end
    it "should initialize a Journey Log with an empty journey history" do
      expect(journey.journey_history).to eq ([])
    end
  end

  context "Start Journey" do
    it "should log entry station as part of single journey on touch in" do
      journey.start(entry_station)
      expect(journey.single_journey[:entry_station]).to eq entry_station
    end
  end

  context "End Journey" do
    it "should log exit station as part of single journey" do
      journey.finish(exit_station)
      expect(journey.single_journey[:exit_station]).to eq exit_station
    end
  end

  context "Adding journeys to journey history" do
    it "should add a journey to the journey history" do
      journey.start(entry_station)
      journey.finish(exit_station)
      journey.add_to_history
      expect(journey.journey_history).to eq [{:entry_station => entry_station, :exit_station => exit_station}]
    end
  end

end

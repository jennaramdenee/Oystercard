require './lib/journey.rb'

describe Journey do

  let(:journey) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }

  context "Initializing" do
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

  context "Finish Journey" do
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
    it "should clear single journey hash" do
      journey.start(entry_station)
      journey.finish(exit_station)
      journey.add_to_history
      expect(journey.single_journey).to eq ({})
    end
    it "can add multiple journeys to history" do
      journey.start(entry_station)
      journey.finish(exit_station)
      journey.start(entry_station)
      journey.finish(exit_station)
      journey.add_to_history
      expect(journey.journey_history).to eq ([{:entry_station => entry_station, :exit_station => exit_station}, {:entry_station => entry_station, :exit_station => exit_station}])
    end
  end

  # context "Incomplete Journeys" do
  #   it "should be able to add to journey when user has not touched in" do
  #     journey.finish(exit_station)
  #     journey.current_journey
  #     expect(journey.single_journey[:entry_station]).to eq "No touch in"
  #   end
  #
  #   it "should be able to add to journey when user has not touched out" do
  #     journey.start(entry_station)
  #     journey.current_journey
  #     expect(journey.single_journey[:exit_station]).to eq "No touch out"
  #   end
  #
  #   it "should be able to detect when user has touched both in and out" do
  #     journey.start(entry_station)
  #     journey.finish(exit_station)
  #     journey.current_journey
  #     expect(journey.single_journey).to eq ({:entry_station => entry_station, :exit_station => exit_station})
  #   end
  #
  #   it "should do nothing when a new journey is started" do
  #     journey.current_journey
  #     expect(journey.single_journey).to eq ({})
  #   end
  #
  # end

  context "Updating journey history" do
    it "can update journey history with incomplete end journey" do
      journey.start(entry_station)
      journey.start(entry_station)
      expect(journey.journey_history).to eq ([{:entry_station => entry_station, :exit_station => "No touch out"}])
    end
    it "can update journey history with incomplete start journey" do
      journey.finish(exit_station)
      journey.start(entry_station)
      expect(journey.journey_history).to eq ([{:entry_station => "No touch in", :exit_station => exit_station}])
    end
    it "can update journey history with complete journey" do
      journey.start(entry_station)
      journey.finish(exit_station)
      journey.start(entry_station)
      expect(journey.journey_history).to eq ([{:entry_station => entry_station, :exit_station => exit_station}])
    end
    it "does not add to history at creation" do
      journey.start(entry_station)
      expect(journey.journey_history).to eq ([])
    end
    it "only adds to history once the next journey has started" do
      journey.start(entry_station)
      journey.finish(exit_station)
      expect(journey.journey_history).to eq ([])
    end

  end
end

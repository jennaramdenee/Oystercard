require './lib/journeylog.rb'

describe JourneyLog do

let(:journey_class) { double(:journey_class) }
let(:journeylog) { described_class.new(journey_class) }
let(:journey) { double(:journey) }
let(:entry_station) { double(:entry_station) }
let(:exit_station) { double(:exit_station) }

before do
  allow(journey_class).to receive(:new).and_return(journey)
  allow(journey).to receive(:touch_in)
  allow(journey).to receive(:touch_out)
end

  context "initializing" do

    it "should initialize a Journey Log to accept a journey object" do
      expect((journeylog).journey).to eq(journey)
    end

    it "should initialize a Journey Log with an empty journey history" do
      expect(journeylog.journey_history).to eq ([])
    end

  end

  context "Start Journey" do

    it "should respond to start method to log entry station" do
      allow(journey).to receive(:journey_store)
      journeylog.start(entry_station)
      expect(journeylog.entry_station).to eq entry_station
    end

  end

  context "End Journey" do

    it "should add exit station when finishing journey" do
      journeylog.finish(exit_station)
      expect(journeylog.exit_station).to eq exit_station
    end

  end

  # context "Current Journey" do
  #
  #   it "should return an incomplete journey" do
  #     journeylog.start(entry_station)
  #     expect(journeylog.current_journey).to eq ({:entry_station => entry_station})
  #   end
  #
  # end

  context "Adding journeys to journey history" do

    it "should add a journey to the journey history" do
      allow(journey).to receive(:journey_store).and_return({:entry_station => entry_station, :exit_station => exit_station})
      journeylog.start(entry_station)
      journeylog.finish(exit_station)
      journeylog.add_to_history
      expect(journeylog.journey_history).to eq [{:entry_station => entry_station, :exit_station => exit_station}]
    end

  end

end

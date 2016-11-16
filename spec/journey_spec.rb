require 'journey'

describe Journey do
  subject(:journey) {described_class.new}

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'expects in journey to be true when start_journey is called' do
    journey.start_journey(entry_station)
    expect(journey.in_journey).to eq true
  end

  it 'expects in journey to be false when finish_journey is called' do
    journey.finish_journey(exit_station)
    expect(journey.in_journey).to eq false
  end

  it 'expects in journey method to return false if journey is ended' do
    journey.finish_journey(exit_station)
    expect(journey.in_journey?).to be false
  end

  it 'logs the entry station when journey is started' do
    journey.start_journey(entry_station)
    expect(journey.entry_station).to eq entry_station
  end

  it 'logs the exit station when journey is complete' do
    journey.finish_journey(exit_station)
    expect(journey.exit_station).to eq exit_station
  end

  describe 'Fare Calculation' do

    it "expects fare to equal #{Journey::PENALTY_FARE} when not touched out" do
      journey.start_journey(entry_station)
      expect(journey.fare).to eq (Journey::PENALTY_FARE)
    end

    it "expects fare to equal #{Journey::PENALTY_FARE} when not touched in" do
      journey.finish_journey(exit_station)
      expect(journey.fare).to eq (Journey::PENALTY_FARE)
    end

    it "expects fare to equal #{Journey::MINIMUM_FARE} when touched in and out" do
      journey.start_journey(entry_station)
      journey.finish_journey(exit_station)
      expect(journey.fare).to eq (Journey::MINIMUM_FARE)
    end

  end

  describe 'Journey log' do

    it 'expects journey history to have an empty array' do
      expect(journey.journey_history).to be_empty
    end

    it 'expects touch out to record journey history' do
      journey.start_journey(entry_station)
      journey.finish_journey(exit_station)
      expect(journey.journey_history).to eq ([{entry_station => exit_station}])
    end

    it 'clears entry station before the start of a new journey' do
      journey.entry_station = "Paddington"
      journey.clear_history
      expect(journey.entry_station).to be nil
    end

    it 'clears exit station once a new journey has started' do
      journey.start_journey(entry_station)
      journey.finish_journey(exit_station)
      expect{journey.start_journey(entry_station)}.to change{journey.exit_station}.from(exit_station).to(nil)
    end

  end

end

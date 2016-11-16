require 'journey'

describe Journey do
  subject(:journey) {described_class.new}

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'expects in journey to be true when start_journey is called' do
    journey.start_journey(entry_station)
    expect(journey.in_journey).to eq true
  end

  it 'expects in journey to be false finish_journey is called' do
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

end

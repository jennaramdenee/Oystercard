require 'journey'

describe Journey do
  subject(:journey) {described_class.new}

  it 'expects in journey to be true when start_journey is called' do
    journey.start_journey
    expect(journey.in_journey).to eq true
  end

  it 'expects in journey to be false finish_journey is called' do
    journey.finish_journey
    expect(journey.in_journey).to eq false
  end

  it 'expects in journey method to return false if journey is ended' do
    journey.finish_journey
    expect(journey.in_journey?).to be false
  end

end

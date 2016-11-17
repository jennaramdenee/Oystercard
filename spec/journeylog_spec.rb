require 'journeylog'

describe JourneyLog do

  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double :journey}

  let(:journey_class) { double :journey_class, new: journey }
  subject(:journey_log) { described_class.new(journey_klass: journey_class) }

  it 'creates empty journey log on instantiation' do
  	expect(journey_log.journeys).to eq []
  end

  it 'starts a journey and logs entry station' do
    journey_log.start(entry_station)
    expect(journey_log.entry_station).to eq entry_station
  end

  it 'ends a journey and logs exit station' do
    journey_log.finish(exit_station)
    expect(journey_log.exit_station).to eq exit_station
  end

  it 'expects to complete a journey' do
    journey_log.start(entry_station)
    journey_log.finish(exit_station)
    expect(journey_log.complete_journey).to eq ({ :journey_start => entry_station, :journey_end => exit_station })
  end

  it 'should return a list of all previous journeys' do
    journey_log.start(entry_station)
    journey_log.finish(exit_station)
    expect(journey_log.journeys).to eq [{ :journey_start => entry_station, :journey_end => exit_station }]
  end
  
end

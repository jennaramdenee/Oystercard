require 'station'

describe Station do
  subject(:station) {described_class.new(1)}

  it 'expect station to have a zone' do
    expect(station.zone).to eq 1
  end
end

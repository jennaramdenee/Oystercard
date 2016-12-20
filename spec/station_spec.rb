require './lib/station.rb'

describe Station do

  before(:each) do
    @hammersmith = Station.new("Hammersmith", 2)
  end

  it "can show the station name" do
    expect(@hammersmith.name).to eq("Hammersmith")
  end

  it "can show the station's zone" do
    expect(@hammersmith.zone).to eq(2)
  end


end

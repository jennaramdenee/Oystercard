require 'journey.rb'

describe Journey do

  let(:journey) { described_class.new }
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station)}

  context "fare method" do

    it "should respond to fare" do
      expect(journey).to respond_to(:fare)
    end

  end

end

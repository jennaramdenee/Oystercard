require 'journeylog.rb'

describe JourneyLog do

  let(:journeylog) { described_class.new }

  context "fare method" do
    it "should respond to fare" do
      expect(journeylog).to respond_to(:fare)
    end

  end

end

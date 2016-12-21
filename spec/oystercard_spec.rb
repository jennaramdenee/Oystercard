<<<<<<< HEAD
require './lib/oystercard.rb'

describe Oystercard do

  let(:station) {double(:station)}
  let(:exit_station) {double(:station)}

  context "Initialize variables" do ##############################

   it "Initializes card with zero balance" do
     expect(subject.balance).to eq 0
   end

   it "Initializes limit with default limit" do
     expect(Oystercard::DEFAULT_MAX_LIMIT).to eq subject.max_limit
   end
 end



  context "Tests top_up method" do #############################
   it "tests that top_up method returns balance + value" do
     expect(subject.top_up(50)).to eq 50
   end

   it "tests that when top_up method is passed more than 90
   it raises an error" do
     expect {subject.top_up(100)}.to raise_error "Top up rejected: exceeds maximum balance of #{subject.max_limit}"
   end
 end


  context "Touch in & Touch Out" do ##############################
    it "tests that initially in_journey? returns false" do
      expect(subject.in_journey?).to eq false
    end

    it "tests that touch_in set a journey_status of true" do
      subject.top_up(50)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end

    it "tests that the constant DEFAULT_MIN_LIMIT is equal to instance variable @min_limit" do
      expect(Oystercard::DEFAULT_MIN_LIMIT).to eq subject.min_limit
    end

    it "tests that touch_in will raise an error if the balance is under minimum amount" do
      expect{subject.touch_in(station)}.to raise_error "Low Funds Error: Please top_up balance"
    end

    it "tests that touch_in will store the station that the user touches in from" do
      subject.top_up(50)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it "tests that touch_out sets a journey_status of false" do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it "tests that touch_out stores a station" do
      subject.top_up(50)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it "tests that minimum limit is deducted from balance after touching out" do
      subject.top_up(50)
      subject.touch_in(station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-1)
    end



  end

  context "Recording a journey" do ##############################

    it 'creates with entry station and exit station when touching out' do
      subject.top_up(50)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.journey).to eq ({:entry_station => station, :exit_station => exit_station })
    end

    it 'creates a card with no journey history' do
      expect(subject.all_journeys).to eq []
    end

    it 'adds a journey to journey history once complete' do
      subject.top_up(50)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.all_journeys).not_to be_empty
    end


  end









end




#unitialized constant
#Users/jennaramdenee/Documents/Week_2/Oystercard/spec/oystercard_spec.rb
#:3
=======
require "oystercard"

describe Oystercard do

  let(:station) { double :station }
  let(:journey) { double :journey }

  before do
    allow(subject.journey).to receive(:start)
    allow(subject.journey).to receive(:finish)
  end

  context "Creation" do
    it "should expect the balance to equal zero for a new card" do
      expect(subject.balance).to eq(0)
    end
    it "should create a new instance of journey" do
      expect(subject.journey).not_to be nil
    end
  end

  context "Top Up" do
    it "should expect the balance to increase when card is topped up" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it "should raise an error when a top up takes the balance over 90" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error("Top up too much. Maximum balance is £#{Oystercard::MAXIMUM_BALANCE}. Current balance is £#{subject.balance}")
    end
  end

  context "Touch In" do
    it "on touch in it should report an error
    when the balance is below the minimum amount" do
    expect{ subject.touch_in(station) }.to raise_error("You do not have sufficient funds. Please top up your card.")
    end
  end

  context "Deductions" do

    it "can deduct an arbitrary number" do
      subject.top_up(10)
      subject.deduct(4)
      expect(subject.balance).to eq 6
    end

    it "should expect the balance to decrease when a fare is charged" do
      allow(subject.journey).to receive(:new_fare).and_return 6
      subject.top_up(20)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.by(-6)
    end
  end
end
>>>>>>> friday

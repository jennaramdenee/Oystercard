require "oystercard"

describe Oystercard do

  let(:station) { double :station }


  context "Create a basic Oystercard" do

    it "should expect the balance to equal zero for a new card" do
      expect(subject.balance).to eq(0)
    end

    it "should expect the balance to increase when card is topped up" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "should raise an error when a top up takes the balance over 90" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { subject.top_up(1) }.to raise_error("Top up too much. Maximum balance is £#{Oystercard::MAXIMUM_BALANCE}. Current balance is £#{subject.balance}")
    end

    it "should create a new instance of journey" do
      expect(subject.journey).not_to be nil
    end

    it "should expect the balance to decrease when a fare is charged" do
      subject.top_up(20)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.by(-1)
    end
  end

  context "Add touch-in touch-out functionality" do

    it "on touch in it should report an error
    when the balance is below the minimum amount" do
    expect{ subject.touch_in(station) }.to raise_error("You do not have sufficient funds. Please top up your card.")
    end

  end

  context "Add touch-in touch-out functionality (with set up)" do

    before(:each) do
      subject.top_up(10)
      subject.touch_in(station)
    end

    it "on touch out it should charge the card the minimum fare" do
      expect{subject.touch_out(station)}.to change{subject.balance}.by(-1)
    end

  end

end

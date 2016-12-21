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

require 'oystercard.rb'

describe OysterCard do
 	subject(:card) {described_class.new}

 	describe 'Card balance' do

    it 'expects a new card to have initial balance of 0' do
     	expect(card.balance).to eq 0
    end

    it 'expects card to be able to be topped up' do
    	card.top_up(10)
    	expect(card.balance).to eq 10
    end

    context 'error checks' do

      it 'should raise error when exceeding maximum balance' do
        message = "Maximum balance of £#{OysterCard::MAXIMUM_BALANCE} cannot be exeeded"
        expect {card.top_up(100)}.to raise_error message
      end

      it 'should raise error when touching in with less than minimum balance' do
      	message = "Insufficient funds"
      	expect {card.touch_in('Aldgate')}.to raise_error message
      end

    end

  end

  describe 'Touch functionality' do

    let(:entry_station) {double(:station)}
    let(:exit_station) {double(:station)}

    before(:each) do
      card.top_up(10)
      card.touch_in(entry_station)
    end

    it 'should return true if touched in' do
      expect(card.journey.in_journey?).to eq true
    end

    it 'should return false if touched out' do
      card.touch_out(exit_station)
      expect(card.journey.in_journey?).to eq false
    end

    it 'should return true if touched in' do
      expect(card.journey).to be_in_journey
    end

    it 'should return false if touched out' do
      card.touch_out(exit_station)
      expect(card.journey).not_to be_in_journey
    end

    it 'expects touch out to deduct minimum fare from balance' do
      expect{card.touch_out(exit_station)}.to change{card.balance}.by(-OysterCard::MINIMUM_FARE)
    end

  end

end

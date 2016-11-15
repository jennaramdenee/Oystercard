require './lib/oystercard.rb'

describe "Feature tests" do


# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

   context "As a customer I want a maximum limit (of £90) on my card" do

        it "When we have a value on the card and top_up past the limit we get an error message" do
         card = Oystercard.new
         card.top_up(50)
         expect{card.top_up(50)}.to raise_error "Top up rejected: exceeds maximum balance of #{card.max_limit}"
       end
  end



  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card



# In order to get through the barriers.
# As a customer
# I need to touch in and out.
# When my journey is complete, I need the correct amount deducted from my card

  context "As a customer, I need to touch in and out" do

    it "Testing whole touch in and out user story" do
      card = Oystercard.new
      expect(card.in_journey?).to eq false
      card.top_up(50)
      card.touch_in('station')
      expect(card.entry_station).to eq 'station'
      expect(card.in_journey?).to eq true
      card.touch_out('station')
      expect(card.in_journey?).to eq false
      expect{card.touch_out('station')}.to change{card.balance}.by(-1)
    end

  end



  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  context "As a customer I need to have the minimum amount (£1) for a single journey." do
    it "Tests that an error is raised when a customer tries to touch in without the default minimum value" do
      card = Oystercard.new
      expect{card.touch_in('station')}.to raise_error "Low Funds Error: Please top_up balance"
    end
  end

  context "As a customer I want to see to all my previous trips" do
    it "Tests that touching in and touching out creates one journey" do
      card = Oystercard.new
      card.top_up(80)
      card.touch_in("Mansion House")
      card.touch_out("London Bridge")
      expect(card.journey).to eq ({:entry_station => "Mansion House", :exit_station => "London Bridge"})
    end

    it "Tests that a customer can view all journeys" do
      card = Oystercard.new
      card.top_up(80)
      card.touch_in("Mansion House")
      card.touch_out("London Bridge")
      card.touch_in("Aldgate East")
      card.touch_out("Putney")
      expect(card.all_journeys).to_not be_empty
    end


  end



end

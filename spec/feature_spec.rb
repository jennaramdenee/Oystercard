require './lib/oystercard.rb'

describe "Feature tests" do

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

   context "As a customer I want a maximum limit (of £90) on my card" do

        it "When we have a value on the card and top_up past the limit we get an error message" do
         card = Oystercard.new
         card.top_up(50)
         expect{card.top_up(50)}.to raise_error "Top up rejected: exceeds maximum balance of #{card.limit}"
       end
  end



  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
   context "As a customer I need my fare deducted from my card" do

     it "When we deduct money from the card that money is removed from value" do
       card = Oystercard.new
       card.top_up(80)
       expect(card.deduct(50)).to eq 30
     end
   end
end

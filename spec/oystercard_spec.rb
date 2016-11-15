require './lib/oystercard.rb'

describe Oystercard do

   it "Initializes card with zero balance" do
     expect(subject.balance).to eq 0
   end

   it "tests that top_up method returns balance + value" do
     expect(subject.top_up(50)).to eq 50
   end








end




#unitialized constant
#Users/jennaramdenee/Documents/Week_2/Oystercard/spec/oystercard_spec.rb
#:3

require './lib/oystercard.rb'

describe Oystercard do

  context "Initialize variables" do

   it "Initializes card with zero balance" do
     expect(subject.balance).to eq 0
   end

   it "Initializes limit with default limit" do
     expect(Oystercard::DEFAULT_LIMIT).to eq subject.limit
   end
 end



  context "Tests top_up method" do
   it "tests that top_up method returns balance + value" do
     expect(subject.top_up(50)).to eq 50
   end

   it "tests that when top_up method is passed more than 90
   it raises an error" do
     expect {subject.top_up(100)}.to raise_error "Top up rejected: exceeds maximum balance of #{subject.limit}"
   end
 end


  context "Tests deduct method" do
    it "tests that duduct method returns balance - value" do
      expect(subject.deduct(100)).to eq -100
    end
  end











end




#unitialized constant
#Users/jennaramdenee/Documents/Week_2/Oystercard/spec/oystercard_spec.rb
#:3

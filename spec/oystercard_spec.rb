require './lib/oystercard.rb'

describe Oystercard do

  context "Initialize variables" do ##############################

   it "Initializes card with zero balance" do
     expect(subject.balance).to eq 0
   end

   it "Initializes limit with default limit" do
     expect(Oystercard::DEFAULT_LIMIT).to eq subject.limit
   end
 end



  context "Tests top_up method" do #############################
   it "tests that top_up method returns balance + value" do
     expect(subject.top_up(50)).to eq 50
   end

   it "tests that when top_up method is passed more than 90
   it raises an error" do
     expect {subject.top_up(100)}.to raise_error "Top up rejected: exceeds maximum balance of #{subject.limit}"
   end
 end


  context "Tests deduct method" do ###############################
    it "tests that duduct method returns balance - value" do
      expect(subject.deduct(100)).to eq -100
    end
  end

  context "Touch in & Touch Out" do ##############################
    it "tests that initially in_journey? returns nil" do
      expect(subject.in_journey?).to eq nil
    end

    it "tests that touch_in set a journey_status of true" do
      subject.top_up(50)
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end

    it "tests that touch_in will raise an error if the balance is under minimum amount" do
      expect{subject.touch_in}.to raise_error "Low Funds Error: Please top_up balance"
    end

    it "tests that touch_out sets a journey_status of false" do
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end











end




#unitialized constant
#Users/jennaramdenee/Documents/Week_2/Oystercard/spec/oystercard_spec.rb
#:3

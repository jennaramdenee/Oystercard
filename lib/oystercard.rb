require_relative "journey.rb"

class Oystercard

attr_reader :balance, :entry_station, :journey_history, :journey

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

def initialize
  @balance = 0
  @journey = Journey.new
end

def top_up(amount)
  fail "Top up too much. Maximum balance is £#{MAXIMUM_BALANCE}. Current balance is £#{@balance}" if @balance + amount > MAXIMUM_BALANCE
  @balance += amount
end

def touch_in(entry_station)
  if @balance < MINIMUM_BALANCE
    fail("You do not have sufficient funds. Please top up your card.")
  else
    @journey.start(entry_station)
  end
end

def touch_out(exit_station)
  @journey.finish(exit_station)
  deduct(@journey.new_fare)
end


def deduct(fare)
  @balance -= fare
end


end

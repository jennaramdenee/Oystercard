<<<<<<< HEAD
class Oystercard
  attr_reader :balance, :max_limit, :min_limit, :entry_station, :exit_station, :journey, :all_journeys

  DEFAULT_MAX_LIMIT = 90
  DEFAULT_MIN_LIMIT = 1

  def initialize
    @balance = 0
    @max_limit = DEFAULT_MAX_LIMIT
    @min_limit = DEFAULT_MIN_LIMIT
    @all_journeys = []
  end

  def top_up(value)
    raise "Top up rejected: exceeds maximum balance of #{@max_limit}" if @balance + value > @max_limit
    @balance += value
  end

  def touch_in(station)
    raise "Low Funds Error: Please top_up balance" if @balance < @min_limit
    @entry_station = station
  end

  def touch_out(station)
    deduct(@min_limit)
    @exit_station = station
    @journey = {:entry_station => @entry_station, :exit_station => @exit_station}
    @all_journeys << @journey
  end

  def in_journey?
    !@entry_station.nil? && @exit_station.nil?
  end

private

  def deduct(value)
    @balance -= value
  end
=======
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
>>>>>>> friday




end

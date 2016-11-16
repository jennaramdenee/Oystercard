require_relative 'station'
require_relative 'journey'

class OysterCard

  attr_reader :balance, :journey_history
  attr_accessor :journey

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAXIMUM_BALANCE} cannot be exeeded" if maximum?(amount)
    @balance += amount
  end


  def touch_in(entry_station)
  	raise "Insufficient funds" if minimum?
    @journey = create_new_journey
    self.journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    self.journey.finish_journey(exit_station)
    deduct(MINIMUM_FARE)
  end

  private

  def create_new_journey
    Journey.new
  end

  def deduct(amount)
    @balance -= amount
  end

  def maximum?(top_up_amount)
    @balance + top_up_amount > MAXIMUM_BALANCE
  end

  def minimum?
  	@balance < MINIMUM_FARE
  end


end

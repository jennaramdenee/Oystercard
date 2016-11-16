require 'station'

class OysterCard

  attr_reader :balance, :journey_history
  attr_accessor :entry_station, :exit_station

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station
    @journey_history = []
    @exit_station
  end

  def top_up(amount)

    raise "Maximum balance of £#{MAXIMUM_BALANCE} cannot be exeeded" if maximum?(amount)
    @balance += amount
  end


  def touch_in(entry_station)
  	raise "Insufficient funds, minimum fare is £#{MINIMUM_FARE}" if minimum?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    self.exit_station = exit_station
    deduct(MINIMUM_FARE)
    self.journey_history << {self.entry_station => self.exit_station}
    clear_history
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def clear_history
    self.entry_station = nil
    self.exit_station = nil
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

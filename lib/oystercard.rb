require_relative 'station'
require_relative 'journey'

class OysterCard

  attr_reader :balance, :journey_history
  attr_accessor :entry_station, :exit_station, :journey

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
    @journey = create_new_journey
    self.journey.start_journey
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    self.journey.finish_journey
    self.exit_station = exit_station
    deduct(MINIMUM_FARE)
    add_to_journey_history
  end

  private

  def create_new_journey
    Journey.new
  end

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

  def add_to_journey_history
    self.journey_history << {self.entry_station => self.exit_station}
    clear_history
  end


end

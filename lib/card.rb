require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_JOURNEY = 1

  attr_reader :balance, :journey_history, :journey

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
  end

  def top_up(top_up_value)
    raise "Can't exceed maximum balance of £#{MAXIMUM_BALANCE}." if maximum?(top_up_value)
    @balance += top_up_value
  end

  def touch_in(entry_station)
    raise "Cannot touch in: minimum required balance is £#{MINIMUM_JOURNEY}, please top up." if minimum?
    new_journey
    journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    journey.end_journey(exit_station)
    store_journey
    deduct(MINIMUM_JOURNEY)
  end

  private

    def deduct(fare)
      @balance -= fare
    end

    def minimum?
      balance < MINIMUM_JOURNEY
    end

    def maximum?(top_up_value)
      @balance + top_up_value > MAXIMUM_BALANCE
    end

    def new_journey
      @journey = Journey.new
    end

    def store_journey
      journey_history << journey.complete_journey
    end

end
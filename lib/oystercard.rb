class OysterCard

  attr_reader :balance
  attr_accessor :entry_station

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station
  end

  def top_up(amount)

    raise "Maximum balance of £#{MAXIMUM_BALANCE} cannot be exeeded" if maximum?(amount)
    @balance += amount
  end


  def touch_in(entry_station)
  	raise "Insufficient funds, minimum fare is £#{MINIMUM_FARE}" if minimum?
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    self.entry_station = nil
    @in_journey = false
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

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

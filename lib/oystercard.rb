class Oystercard
  attr_reader :balance, :limit

  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
    @limit = DEFAULT_LIMIT
  end

  def top_up(value)
    raise "Top up rejected: exceeds maximum balance of #{@limit}" if @balance + value > @limit
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end






end

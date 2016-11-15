class Oystercard
  attr_reader :balance, :max_limit, :min_limit

  DEFAULT_MAX_LIMIT = 90
  DEFAULT_MIN_LIMIT = 1

  def initialize
    @balance = 0
    @max_limit = DEFAULT_MAX_LIMIT
    @min_limit = DEFAULT_MIN_LIMIT
  end

  def top_up(value)
    raise "Top up rejected: exceeds maximum balance of #{@max_limit}" if @balance + value > @max_limit
    @balance += value
  end

  def touch_in
    raise "Low Funds Error: Please top_up balance" if @balance < @min_limit
    @journey_status = true
  end

  def touch_out
    @journey_status = false
    deduct(@min_limit)
  end

  def in_journey?
    @journey_status
  end

private

  def deduct(value)
    @balance -= value
  end




end

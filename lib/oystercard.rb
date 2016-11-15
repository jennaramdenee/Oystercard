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




end

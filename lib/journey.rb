class Journey

  attr_accessor :in_journey, :entry_station, :exit_station, :journey_history

  PENALTY_FARE = 6
  MINIMUM_FARE = 1


  def initialize
    @in_journey = false
    @entry_station
    @exit_station
    @journey_history = []
  end

  def start_journey(entry_station)
    @entry_station = entry_station
    self.in_journey = true
  end

  def finish_journey(exit_station)
    @exit_station = exit_station
    self.in_journey = false
    add_to_journey_history
  end

  def in_journey?
    self.in_journey
  end

  def fare
    return PENALTY_FARE if @entry_station.nil? || @exit_station.nil?
    MINIMUM_FARE
  end

  def add_to_journey_history
    self.journey_history << {self.entry_station => self.exit_station}
  end

end

class Journey

  attr_reader :entry_station, :exit_station

    MINIMUM_FARE = 1
    PENALTY_FARE = 6

  def fare
    return PENALTY_FARE if completed? == false
    MINIMUM_FARE
  end

end

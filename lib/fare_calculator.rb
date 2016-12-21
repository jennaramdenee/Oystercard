class FareCalculator

  attr_reader :journey_history

    PENALTY_FARE = 6

  def fare(entry_station, exit_station)
    return PENALTY_FARE if entry_station == "No touch in" || exit_station == "No touch out"
    return (exit_station.zone - entry_station.zone).abs + 1
  end



end

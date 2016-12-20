class fareCalculator

  attr_reader :journey_history

    MINIMUM_FARE = 1
    PENALTY_FARE = 6

  def fare
    return PENALTY_FARE if completed? == false
    MINIMUM_FARE
  end

end

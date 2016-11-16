class Journey

  attr_accessor :in_journey

  PENALTY_FARE = 6

  def initialize
    @in_journey = false
  end

  def start_journey
    self.in_journey = true
  end

  def finish_journey
    self.in_journey = false
  end

  def in_journey?
    self.in_journey
  end

  def fare
    

end

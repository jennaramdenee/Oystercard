class Journey

  attr_reader :single_journey, :journey_history

  def initialize
    @journey_history = []
    @single_journey = {}
  end

  def current_journey
    unless @single_journey == {}
      if @single_journey.has_key?(:exit_station) == false
        @single_journey[:exit_station] = "No touch out"
      elsif @single_journey.has_key?(:entry_station) == false
        @single_journey[:entry_station] = "No touch in"
      end
      add_to_history
    end
  end

  def start(entry_station)
    current_journey
    @single_journey[:entry_station] = entry_station
  end

  def finish(exit_station)
    @single_journey[:exit_station] = exit_station
  end

  def add_to_history
    @journey_history << @single_journey
    @single_journey = {}
  end

end

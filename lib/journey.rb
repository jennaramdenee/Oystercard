require './lib/fare_calculator.rb'

class Journey

  attr_reader :single_journey, :journey_history, :new_fare

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
      @new_fare = FareCalculator.new.fare(@single_journey[:entry_station], @single_journey[:exit_station])
      add_to_history
    end
  end

  def start(entry_station)
    @single_journey[:entry_station] = entry_station
  end

  def finish(exit_station)
    @single_journey[:exit_station] = exit_station
    current_journey
  end

  def add_to_history
    @journey_history << @single_journey
    @single_journey = {}
  end

end

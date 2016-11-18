require './lib/journey'

class JourneyLog

  attr_reader :journey, :entry_station, :journey_history, :exit_station, :single_journey, :new_journey

  def initialize(journey_class)
    @journey = journey_class
    @journey_history = []
    @single_journey = {}
  end

  def current_journey
    if @single_journey.has_key?(:exit_station) == false
      @single_journey[:exit_station] = "No touch out"
      add_to_history
    elsif @single_journey.has_key?(:entry_station) == false
      @single_journey[:entry_station] = "No touch in"
      add_to_history
    elsif @single_journey == {}
      @new_journey = @journey.new
    else
      add_to_history
      @new_journey = @journey.new
    end
  end

  def start(entry_station)
    current_journey
    @entry_station = entry_station
    @single_journey[:entry_station] = entry_station
    @new_journey.touch_in(entry_station)
  end

  def finish(exit_station)
    @exit_station = exit_station
    @single_journey[:exit_station] = exit_station
    @new_journey.touch_out(exit_station)
  end

  def add_to_history
    @journey_history << @single_journey
    @single_journey = {}
    end

end

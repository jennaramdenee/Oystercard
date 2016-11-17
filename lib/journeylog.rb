require_relative 'journey'

class JourneyLog

	attr_accessor :journeys, :entry_station, :exit_station

  def initialize(journey_klass: )
    @journey_class = journey_klass.new
    @journeys = []
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    store_journey
  end

  def complete_journey
		{ :journey_start => self.entry_station, :journey_end => self.exit_station }
	end

	def store_journey
		self.journeys << complete_journey
	end

  private

  def current_journey
    return "Incomplete Journey" if self.exit_station.nil?
    Journey.new
  end

end

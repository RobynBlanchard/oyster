class JourneyHistory

  attr_reader :journeys

  def initialize(journeys=[])
    @journeys = journeys
  end

  def add(journey)
    journeys << journey
  end
end

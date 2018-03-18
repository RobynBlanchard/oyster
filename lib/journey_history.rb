class JourneyHistory
  
  PENALTY_FARE = 5

  attr_accessor :journeys

  def initialize(journeys=[])
    @journeys = journeys
  end

  def add(journey)
    journeys << journey
  end
end

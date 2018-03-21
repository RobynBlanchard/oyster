class Journey

  PENALTY_FARE = 4.7

  ZONE_FARES =  [
                [2.4, 2.9, 3.3, 3.9, 4.7],
                [2.9, 1.7, 1.7, 2.4, 2.8],
                [3.3, 1.7, 1.7, 1.7, 2.4],
                [3.9, 2.4, 1.7, 1.7, 1.7],
                [4.7, 2.8, 2.4, 1.7, 1.7]
                ]

  attr_reader :start_zone, :end_zone, :fare

  def initialize(start_zone: start_zone)
    @start_zone = start_zone
  end

  def end_journey(end_zone)
    fare = calculate_fare(start_zone, end_zone)
    if end_zone.nil? || start_zone.nil?
      fare += PENALTY_FARE
    end
    set_journey_values(end_zone, fare)
  end

  private

  # If the start or end zone is not known then the fare is calculated by
  # caulcating the most expensive possible journey from the given zone
  def calculate_fare(start_zone=nil, end_zone=nil)
    start_zone ||= 1
    end_zone ||= 1
    fare = ZONE_FARES[start_zone - 1][end_zone - 1]
  end

  def set_journey_values(end_zone, fare)
    @end_zone = end_zone
    @fare = fare
  end
end

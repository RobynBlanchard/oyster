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

  def initialize(start_zone)
    @start_zone = start_zone
  end

  def end_journey(end_zone)
    if end_zone.nil? || start_zone.nil?
      calculate_penalty_fare(end_zone)
    else
      calculate_fare(end_zone)
    end
  end

  private

  def calculate_fare(end_zone)
    fare = ZONE_FARES[@start_zone - 1][end_zone -1]
    @end_zone = end_zone
    @fare = fare
  end

  def calculate_penalty_fare(end_zone)
    if @start_zone.nil?
      # TODO - change use of end_zone here - calculate max fare from endzone
      fare = ZONE_FARES[end_zone - 1][end_zone -1] + PENALTY_FARE
    elsif end_zone.nil?
      fare = ZONE_FARES[@start_zone - 1][@start_zone -1] + PENALTY_FARE
    end
    @end_zone = end_zone
    @fare = fare
  end
end

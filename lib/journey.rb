class Journey

  ZONE_FARES =  [
                [2.4, 2.9, 3.3, 3.9, 4.7],
                [2.9, 1.7, 1.7, 2.4, 2.8],
                [3.3, 1.7, 1.7, 1.7, 2.4],
                [3.9, 2.4, 1.7, 1.7, 1.7],
                [4.7, 2.8, 2.4, 1.7, 1.7]
                ]

  attr_reader :start_zone, :end_zone, :fare

  def initialize(start_zone)
    #self.balance = balance
    @start_zone = start_zone
    @end_zone
    @fare
  end

  def calculate_fare(end_zone)
    fare = ZONE_FARES[@start_zone - 1][end_zone -1]
    @end_zone = end_zone
    @fare = fare
    fare
  end
end

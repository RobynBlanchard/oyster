class Journey
  attr_accessor :balance, :start_zone

  def initialize(balance, start_zone)
    self.balance = balance
    self.start_zone = start_zone
  end

  def self.minimum_fare
    1.7
  end

  def self.penalty_fare
    5
  end

  def calculate_fare(end_zone)
    zone_fares =  [
                  [2.4, 2.9, 3.3, 3.9, 4.7],
                  [2.9, 1.7, 1.7, 2.4, 2.8],
                  [3.3, 1.7, 1.7, 1.7, 2.4],
                  [3.9, 2.4, 1.7, 1.7, 1.7],
                  [4.7, 2.8, 2.4, 1.7, 1.7]
                  ]

    zone_fares[self.start_zone - 1][end_zone -1]
  end
end

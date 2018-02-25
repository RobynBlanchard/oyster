class Journey
  attr_accessor :balance, :zone

  def initialize(balance, zone)
    self.balance = balance
    self.zone = zone
  end

  def self.minimum_fare
    1
  end

  def self.single_fare
    3
  end

  def calculate_fare(zone)
    Journey.single_fare
  end
end

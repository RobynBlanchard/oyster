class Journey
  attr_accessor :balance
  def initialize(balance)
    self.balance = balance
  end

  def self.minimum_fare
    1
  end
end

class Oyster
  attr_accessor :balance, :customer_id

  def initialize(balance=0, customer_id)
    self.balance = balance
    self.customer_id = customer_id
  end

  def top_up(amount)
    self.balance += amount
  end
end

class Oyster
  attr_accessor :balance, :customer_id

  def initialize(balance=0, customer_id)
    self.balance = balance
    self.customer_id = customer_id
  end

  def top_up(amount)
    max_top_up = 50
    if amount > max_top_up
      puts "You cannot top up your Oyster with an amount greater than #{max_top_up}"
    else
      self.balance += amount
    end
  end

  def deduct_fare(amount)
    self.balance -= amount
  end

  def tap_in
  end

  def tap_out
  end
end

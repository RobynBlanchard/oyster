require 'journey'
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

  def tap_in(zone)
    if self.balance < ::Journey.minimum_fare
     puts "Top up Oyster Card"
    else
      @j = Journey.new(self.balance, zone)
    end
  end

  def tap_out(zone)
    fare = @j.calculate_fare(zone)
    deduct_fare(fare)
  end

end

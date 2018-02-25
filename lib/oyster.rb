require 'journey'
class Oyster

  attr_accessor :balance, :customer_id, :trip_history

  def initialize(balance=0, customer_id)
    self.balance = balance
    self.customer_id = customer_id
    self.trip_history = TripHistory.new(customer_id)
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

  def tap_in(start_zone)
    if self.balance < ::Journey.minimum_fare
     puts "Top up Oyster Card"
    else
      @journey = Journey.new(self.balance, start_zone)
    end
  end

  def tap_out(end_zone)
    fare = @journey.calculate_fare(end_zone)
    deduct_fare(fare)
    self.trip_history.save(@journey.start_zone, end_zone, fare)
  end

end

require './lib/journey'
require './lib/trip_history'

class Oyster

  MAX_TOP_UP = 50
  MINIMUM_FARE = 1.7

  attr_reader :balance, :customer_id, :trip_history

  def initialize(balance=0, customer_id)
    @balance = balance
    @customer_id = customer_id
    @trip_history = TripHistory.new(customer_id)
  end

  def top_up(amount)
    if amount > MAX_TOP_UP
      raise "You cannot top up your Oyster with an amount greater than #{max_top_up}"
    else
      @balance += amount
    end
  end

  # elsif tap in and didnt tap out - apply penalty fare
  def tap_in(start_zone)
    if balance < MINIMUM_FARE
     raise "Top up Oyster Card"
    else
      start_journey(start_zone)
    end
  end

  def tap_out(journey, end_zone)
    fare = end_journey(journey, end_zone)
    deduct_fare(fare)
    @trip_history.save(journey)
  end

  private

  def start_journey(start_zone)
    #journey nil?
    journey = Journey.new(start_zone)
  end

  def end_journey(journey, end_zone)
    fare = journey.calculate_fare(end_zone)
  end


  def deduct_fare(amount)
    @balance -= amount
  end
end

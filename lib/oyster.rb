require './lib/journey'
# require './lib/trip_history'

class MaxTopUpError < StandardError
  def initialize
    super("You cannot top up your Oyster with that much!")
  end
end

class BalanceBelowRequiredError < StandardError
  def initialize
    super("Please top up!")
  end
end


class Oyster
  MAX_TOP_UP = 50
  MINIMUM_FARE = 1.7

  attr_reader :balance, :journey

  def initialize(balance: 0)
    @balance = balance
  end

  def top_up(amount)
    if amount > MAX_TOP_UP
      raise MaxTopUpError.new
    else
      @balance += amount
    end
  end

  # elsif tap in and didnt tap out - apply penalty fare
  def tap_in(start_zone)
    if balance < MINIMUM_FARE
     raise BalanceBelowRequiredError.new
    else
      start_journey(start_zone)
    end
  end

  def tap_out(end_zone)
    end_journey(end_zone)
    # @journey = nil
  end

  private

  def start_journey(start_zone)
    if @journey.nil?
      @journey = Journey.new(start_zone: start_zone)
    else
      # end journey applying penalty fare
    end
  end

  def end_journey(end_zone)
    if @journey.nil?
      journey = Journey.new(start_zone: end_zone)
      fare = journey.calculate_penalty_fare(end_zone)
      deduct_fare(fare)
    else
      fare = @journey.calculate_fare(end_zone)
      deduct_fare(fare)
    end
  end


  def deduct_fare(amount)
    @balance -= amount
  end
end

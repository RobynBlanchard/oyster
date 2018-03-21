require './lib/journey'
require './lib/journey_history'
require './lib/errors'

class Oyster

  MAX_TOP_UP = 50
  MINIMUM_FARE = 1.7

  attr_reader :balance, :journey_history, :journey

  def initialize(balance: 0)
    @balance = balance
    @journey_history = JourneyHistory.new()
  end

  def top_up(amount)
    if amount > MAX_TOP_UP
      raise MaxTopUpError.new
    else
      @balance += amount
    end
  end

  def tap_in(start_zone)
    if balance.to_f < MINIMUM_FARE
     raise BalanceBelowRequiredError.new
    else
      start_journey(start_zone)
    end
  end

  def tap_out(end_zone)
    fare = end_journey(end_zone)
    deduct_fare(fare)
    save_journey
  end

  private

  def start_journey(start_zone)
    unless @journey.nil?
      tap_out(nil)
    end
    @journey  = Journey.new(start_zone: start_zone)
  end

  def end_journey(end_zone)
    if @journey.nil?
      @journey = Journey.new(start_zone: nil)
    end
    @journey.end_journey(end_zone)
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def save_journey
    @journey_history.add(@journey)
    @journey = nil
  end
end

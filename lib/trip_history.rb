class TripHistory
  PENALTY_FARE = 5

  attr_accessor :customer_id, :trips

  def initialize(customer_id, trips=[])
    self.customer_id = customer_id
    self.trips = trips
  end

  def save(journey)
    #self.trips << {"start_zone"=>start_zone, "end_zone"=>end_zone, "fare"=>fare}
    @trips << journey
  end
end

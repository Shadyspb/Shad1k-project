class CarriagePassenger < Carriage
  def initialize(num, place)
    super(:passenger)
    @num = num.to_i
    @place = place.to_i
    @takeed_place = 0
  end

  def take_place
    @takeed_place += 1
  end

  def free_place
    @place - @takeed_place
  end

  def look_free_places
    "Номер вагона #{num} тип #{self.type}, занято мест - #{@takeed_place}, свободных мест - #{free_place}"
  end
end

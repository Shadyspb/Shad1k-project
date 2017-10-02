class CarriagePassenger < Carriage
  def initialize(num, place)
    super(:passenger)
    @num = num.to_i
    @place = place.to_i
    @taken_place = 0
  end

  def take_place
    @taken_place += 1 if @taken_place < @place
  end

  def free_place
    @place - @taken_place
  end

  def to_s
    "Номер вагона #{num} тип #{self.type}, занято мест - #{@taken_place}, свободных мест - #{free_place}"
  end
end

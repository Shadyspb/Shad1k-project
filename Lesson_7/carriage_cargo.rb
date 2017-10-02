class CarriageCargo < Carriage
  def initialize(num, capacity)
    super(:cargo)
    @num = num.to_i
    @capacity = capacity.to_f
    @free_capacity = @capacity
  end

  def load(capacity)
    @free_capacity -= capacity if @free_capacity -= capacity > 0
  end

  def occupied_place
    @capacity - @free_capacity
  end

  def to_s
    "Номер вагона - #{num} тип - #{self.type}, занятый объём - #{occupy_capacity}, cвободный объем - #{@free_capacity}"
  end
end

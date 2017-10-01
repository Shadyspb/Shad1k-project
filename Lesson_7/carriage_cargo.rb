class CarriageCargo < Carriage
  def initialize(num, capacity)
    super(:cargo)
    @num = num.to_i
    @capacity = capacity.to_i
    @free_capacity = @capacity
  end

  def load(capacity)
    @free_capacity -= capacity
  end

  def occupy_capacity
    @capacity - @free_capacity
  end

  def look_free_capacity
    "Номер вагона - #{num} тип - #{self.type}, занятый объём - #{occupy_capacity}, cвободный объем - #{@free_capacity}"
  end
end

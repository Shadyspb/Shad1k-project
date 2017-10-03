class CarriageCargo < Carriage
  def initialize(num, capacity)
    super(:cargo)
    @num = num.to_i
    @capacity = capacity.to_f
    @load_capacity = 0
  end

  def load_capacity(capacity)
    @load_capacity += capacity if @capacity - capacity > 0
  end

  def occupied_place
    free_capacity = @capacity - @load_capacity
  end

  def to_s
    "Номер вагона - #{@num} тип - #{self.type}, занятый объём - #{@load_capacity}, cвободный объем - #{occupied_place}"
  end
end

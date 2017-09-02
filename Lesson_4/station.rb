class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def types_of_trains(type)
    trains.select { |train| train.type == type }
  end

  def delete_train(train)
    trains.delete(train)
  end
end
